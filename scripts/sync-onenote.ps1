<#
.SYNOPSIS
  OneNote 데스크톱 앱(로컬 전용 노트북)의 변경된/새 페이지만 감지해서
  notes/erp-개발/<섹션명>/*.md 로 증분 동기화하고 git commit & push 까지 자동 수행합니다.

.DESCRIPTION
  - OneNote COM 자동화(Interop)로 전체 계층(노트북/섹션그룹/섹션/페이지)을 조회
  - 각 페이지의 lastModifiedTime을 이전 동기화 상태(sync-state.json)와 비교해서
    새 페이지 / 수정된 페이지만 선택적으로 처리 (변경 없는 페이지는 건너뜀)
  - 페이지 단위로 Publish(→docx) 후 pandoc으로 마크다운 변환, WMF/EMF 이미지는 PNG로 변환
  - 페이지 제목이 바뀌었거나 파일명이 바뀌어야 하는 경우 이전 산출물을 정리하고 새로 생성
  - 삭제된 페이지는 대응하는 노트 파일/이미지 폴더를 삭제
  - 변경 사항이 있으면 notes/ 만 git add 하여 커밋 후 origin main 으로 push
  - Windows 작업 스케줄러에서 매일 1회 실행하도록 등록해서 사용
#>

$ErrorActionPreference = "Stop"

$Root      = "C:\WorkSpace\AI"
$ExportDir = Join-Path $Root "_onenote-export"
$NotesRoot = Join-Path $Root "notes\erp-개발"
$Pandoc    = Join-Path $Root "_tools\pandoc-3.10.1\pandoc.exe"
$StatePath = Join-Path $ExportDir "sync-state.json"
$LogDir    = Join-Path $ExportDir "sync-logs"
$WorkDir   = Join-Path $ExportDir "_sync_work"

if (-not (Test-Path $Pandoc)) { throw "pandoc.exe를 찾을 수 없습니다: $Pandoc" }
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
New-Item -ItemType Directory -Force -Path $WorkDir | Out-Null

$logFile = Join-Path $LogDir ("sync-{0}.log" -f (Get-Date -Format "yyyy-MM-dd_HHmmss"))
Start-Transcript -Path $logFile | Out-Null

Add-Type -AssemblyName System.Drawing

function Convert-ToSlug($text) {
    $slug = $text.Trim()
    $slug = $slug -replace '[\\/:*?"<>|]', '-'
    $slug = $slug -replace '\s+', '-'
    $slug = $slug -replace '-{2,}', '-'
    $slug = $slug.Trim('-')
    if ($slug.Length -gt 80) { $slug = $slug.Substring(0, 80) }
    if ([string]::IsNullOrWhiteSpace($slug)) { $slug = "untitled" }
    return $slug
}

function Convert-WmfImages($mediaDir) {
    if (-not (Test-Path $mediaDir)) { return }
    Get-ChildItem $mediaDir -Recurse -Include *.wmf, *.emf -ErrorAction SilentlyContinue | ForEach-Object {
        $src = $_.FullName
        $dst = [IO.Path]::ChangeExtension($src, "png")
        try {
            $mf = New-Object System.Drawing.Imaging.Metafile($src)
            $w = [Math]::Max(1, $mf.Width)
            $h = [Math]::Max(1, $mf.Height)
            $bmp = New-Object System.Drawing.Bitmap $w, $h
            $g = [System.Drawing.Graphics]::FromImage($bmp)
            $g.Clear([System.Drawing.Color]::White)
            $g.DrawImage($mf, 0, 0, $w, $h)
            $bmp.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
            $g.Dispose(); $bmp.Dispose(); $mf.Dispose()
            Remove-Item $src -Force
        } catch {
            Write-Warning "WMF/EMF 변환 실패: $src ($($_.Exception.Message))"
        }
    }
}

# ---- 이전 동기화 상태 로드 ----
$stateMap = @{}
if (Test-Path $StatePath) {
    $raw = Get-Content -Raw -Encoding UTF8 $StatePath
    if ($raw.Trim().Length -gt 0) {
        $obj = $raw | ConvertFrom-Json
        foreach ($p in $obj.PSObject.Properties) { $stateMap[$p.Name] = $p.Value }
    }
}

# ---- OneNote 계층 조회 ----
$onenote = New-Object -ComObject OneNote.Application
$xmlStr = ""
$onenote.GetHierarchy("", [Microsoft.Office.Interop.OneNote.HierarchyScope]::hsPages, [ref]$xmlStr)
[xml]$h = $xmlStr
$ns = New-Object System.Xml.XmlNamespaceManager($h.NameTable)
$ns.AddNamespace("one", "http://schemas.microsoft.com/office/onenote/2013/onenote")

$currentPageIds = New-Object System.Collections.Generic.HashSet[string]
$script:changedCount = 0
$script:errorCount = 0

$headerPattern = '^(?<title>[^\r\n]+)\r?\n\r?\n(?<date>\d{4}년\s*\d{1,2}월\s*\d{1,2}일\s*[월화수목금토일]요일)\r?\n\r?\n(?<time>(오전|오후)\s*\d{1,2}:\d{2})\r?\n\r?\n'
$imgPattern = '<img\s+src="([^"]+)"[^>]*/?>'

function Sync-Section($sectionNode, $sectionName) {
    $pages = $sectionNode.SelectNodes("one:Page", $ns)
    $sectionOut = Join-Path $NotesRoot $sectionName

    foreach ($page in $pages) {
        $pageId = $page.ID
        [void]$currentPageIds.Add($pageId)
        $lastMod = $page.lastModifiedTime

        $prevEntry = $null
        if ($stateMap.ContainsKey($pageId)) { $prevEntry = $stateMap[$pageId] }
        if ($prevEntry -and $prevEntry.lastModifiedTime -eq $lastMod) { continue }

        Write-Host "동기화: [$sectionName] $($page.name)"
        New-Item -ItemType Directory -Force -Path $sectionOut | Out-Null

        $safeId = ($pageId -replace '[{}:]', '')
        $pageWork = Join-Path $WorkDir $safeId
        if (Test-Path $pageWork) { Remove-Item $pageWork -Recurse -Force }
        New-Item -ItemType Directory -Force -Path $pageWork | Out-Null
        $docxPath = Join-Path $pageWork "page.docx"

        try {
            $onenote.Publish($pageId, $docxPath, [Microsoft.Office.Interop.OneNote.PublishFormat]::pfWord, "")
        } catch {
            Write-Warning "Publish 실패: $($page.name) - $($_.Exception.Message)"
            $script:errorCount++
            continue
        }

        $mdPath = Join-Path $pageWork "page.md"
        & $Pandoc $docxPath -f docx -t gfm -o $mdPath --extract-media=$pageWork --wrap=none
        if (-not (Test-Path $mdPath)) {
            Write-Warning "pandoc 변환 실패: $($page.name)"
            $script:errorCount++
            continue
        }

        Convert-WmfImages (Join-Path $pageWork "media")

        $body = Get-Content -Raw -Encoding UTF8 $mdPath
        $body = [regex]::Replace($body, $headerPattern, "", 1)
        $body = $body.Trim()

        $slug = Convert-ToSlug $page.name
        $dateIso = ""
        if ($page.dateTime) {
            try { $dateIso = ([datetime]$page.dateTime).ToString("yyyy-MM-dd") } catch {}
        }
        $fileNamePrefix = if ($dateIso) { "$dateIso-$slug" } else { $slug }
        $outFile = Join-Path $sectionOut ("$fileNamePrefix.md")

        # 이전 산출물이 이번과 파일명/섹션이 다르면 정리 (제목 변경 등으로 인한 잔존 파일 방지)
        if ($prevEntry -and $prevEntry.file) {
            $prevFullPath = Join-Path $Root ($prevEntry.file -replace '/', '\')
            if ($prevFullPath -ne $outFile -and (Test-Path -LiteralPath $prevFullPath)) {
                Remove-Item -LiteralPath $prevFullPath -Force -ErrorAction SilentlyContinue
            }
            if ($prevEntry.assetsDir) {
                $prevAssets = Join-Path $Root ($prevEntry.assetsDir -replace '/', '\')
                if (Test-Path -LiteralPath $prevAssets) { Remove-Item -LiteralPath $prevAssets -Recurse -Force -ErrorAction SilentlyContinue }
            }
        }

        $pageAssetsDir = Join-Path $sectionOut (Join-Path "assets" $slug)
        if (Test-Path -LiteralPath $pageAssetsDir) { Remove-Item -LiteralPath $pageAssetsDir -Recurse -Force }

        $body = [regex]::Replace($body, $imgPattern, {
            param($match)
            $srcPath = $match.Groups[1].Value -replace '/', '\'
            if (-not (Test-Path -LiteralPath $srcPath)) {
                $pngGuess = [IO.Path]::ChangeExtension($srcPath, "png")
                if (Test-Path -LiteralPath $pngGuess) { $srcPath = $pngGuess } else { return "" }
            }
            New-Item -ItemType Directory -Force -Path $pageAssetsDir | Out-Null
            $imgName = Split-Path $srcPath -Leaf
            $destPath = Join-Path $pageAssetsDir $imgName
            Copy-Item -LiteralPath $srcPath $destPath -Force
            return "![](assets/$slug/$imgName)"
        })

        $titleYaml = '"' + ($page.name -replace '"', '\"') + '"'
        $tagsYaml = "[erp, 개발, $sectionName]"
        $frontmatter = @"
---
title: $titleYaml
date: $dateIso
tags: $tagsYaml
---

# $($page.name)

$body
"@
        [System.IO.File]::WriteAllText($outFile, $frontmatter, (New-Object System.Text.UTF8Encoding($false)))

        $relOut = $outFile.Substring($Root.Length + 1).Replace('\', '/')
        $relAssets = $pageAssetsDir.Substring($Root.Length + 1).Replace('\', '/')

        $stateMap[$pageId] = [PSCustomObject]@{
            lastModifiedTime = $lastMod
            file             = $relOut
            assetsDir        = $relAssets
            sectionName      = $sectionName
        }

        Remove-Item $pageWork -Recurse -Force -ErrorAction SilentlyContinue
        $script:changedCount++
    }
}

function Sync-Node($node) {
    $sections = $node.SelectNodes("one:Section", $ns)
    foreach ($sec in $sections) { Sync-Section $sec $sec.name }

    $groups = $node.SelectNodes("one:SectionGroup", $ns)
    foreach ($g in $groups) {
        if ($g.name -eq "OneNote_RecycleBin") { continue }
        Sync-Node $g
    }
}

$notebooks = $h.SelectNodes("//one:Notebook", $ns)
foreach ($nb in $notebooks) { Sync-Node $nb }

# ---- 삭제된 페이지 정리 ----
$deletedIds = @($stateMap.Keys | Where-Object { -not $currentPageIds.Contains($_) })
$script:deletedCount = 0
foreach ($id in $deletedIds) {
    $entry = $stateMap[$id]
    Write-Host "삭제 감지: $($entry.file)"
    if ($entry.file) {
        $fullPath = Join-Path $Root ($entry.file -replace '/', '\')
        if (Test-Path -LiteralPath $fullPath) { Remove-Item -LiteralPath $fullPath -Force }
    }
    if ($entry.assetsDir) {
        $assetsFull = Join-Path $Root ($entry.assetsDir -replace '/', '\')
        if (Test-Path -LiteralPath $assetsFull) { Remove-Item -LiteralPath $assetsFull -Recurse -Force }
    }
    $stateMap.Remove($id)
    $script:deletedCount++
}

# ---- 상태 저장 ----
($stateMap | ConvertTo-Json -Depth 5) | Out-File -FilePath $StatePath -Encoding utf8

Write-Host "`n=== 동기화 결과 ==="
Write-Host "변경/신규: $changedCount, 삭제: $deletedCount, 오류: $errorCount"

if ($changedCount -gt 0 -or $deletedCount -gt 0) {
    Set-Location $Root
    git add notes
    $hasStaged = git diff --cached --name-only
    if ($hasStaged) {
        $commitMsg = "Auto-sync OneNote notes " + (Get-Date -Format "yyyy-MM-dd HH:mm")
        git commit -m $commitMsg
        git push origin main
        Write-Host "Git push 완료: $commitMsg"
    } else {
        Write-Host "실질적인 파일 변경 없음, commit 생략"
    }
} else {
    Write-Host "변경 사항 없음, git push 생략"
}

Stop-Transcript | Out-Null
