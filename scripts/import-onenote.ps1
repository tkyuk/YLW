<#
.SYNOPSIS
  OneNote에서 내보낸 .docx 파일들(C:\WorkSpace\AI\_onenote-export\*.docx)을
  notes/erp-개발/<섹션명>/*.md 로 일괄 변환합니다.

.DESCRIPTION
  - pandoc으로 docx -> gfm 마크다운 변환 (이미지 추출 포함)
  - WMF/EMF 이미지는 PNG로 변환
  - OneNote 페이지 구분 패턴(제목 / 날짜 / 시간)을 기준으로 각 페이지를 개별 노트 파일로 분리
  - 각 노트에 frontmatter(title, date, tags) 추가
  - 페이지 안에서 실제로 참조된 이미지만 assets 폴더로 복사하고 상대경로로 재작성
#>

$ErrorActionPreference = "Stop"

$Root       = "C:\WorkSpace\AI"
$ExportDir  = Join-Path $Root "_onenote-export"
$NotesRoot  = Join-Path $Root "notes\erp-개발"
$Pandoc     = Join-Path $Root "_tools\pandoc-3.10.1\pandoc.exe"

if (-not (Test-Path $Pandoc)) { throw "pandoc.exe를 찾을 수 없습니다: $Pandoc" }

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

function Convert-KoreanDateToIso($dateStr) {
    if ($dateStr -match '(\d{4})년\s*(\d{1,2})월\s*(\d{1,2})일') {
        return "{0}-{1:D2}-{2:D2}" -f [int]$matches[1], [int]$matches[2], [int]$matches[3]
    }
    return ""
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

$docxFiles = Get-ChildItem $ExportDir -Filter "*.docx" -ErrorAction SilentlyContinue
if (-not $docxFiles) { throw "$ExportDir 에 .docx 파일이 없습니다." }

foreach ($file in $docxFiles) {
    $sectionName = $file.BaseName
    Write-Host "=== 섹션 처리 중: $sectionName ===" -ForegroundColor Cyan

    $workDir   = Join-Path $ExportDir ("_work_" + $sectionName)
    $mediaDir  = Join-Path $workDir "media"
    $mdPath    = Join-Path $workDir "raw.md"
    $sectionOut = Join-Path $NotesRoot $sectionName

    New-Item -ItemType Directory -Force -Path $workDir | Out-Null
    New-Item -ItemType Directory -Force -Path $sectionOut | Out-Null

    & $Pandoc $file.FullName -f docx -t gfm -o $mdPath --extract-media=$workDir --wrap=none
    if ($LASTEXITCODE -ne 0) { Write-Warning "pandoc 변환 실패: $($file.FullName)"; continue }

    Convert-WmfImages $mediaDir

    $text = Get-Content -Raw -Encoding UTF8 $mdPath

    # 페이지 경계 패턴: 제목 \n\n 날짜 \n\n 시간 \n\n
    $pattern = '(?m)^(?<title>[^\r\n]+)\r?\n\r?\n(?<date>\d{4}년\s*\d{1,2}월\s*\d{1,2}일\s*[월화수목금토일]요일)\r?\n\r?\n(?<time>(오전|오후)\s*\d{1,2}:\d{2})\r?\n\r?\n'
    $ms = [regex]::Matches($text, $pattern)

    if ($ms.Count -eq 0) {
        Write-Warning "페이지 패턴을 찾지 못했습니다: $sectionName (전체를 노트 1개로 저장합니다)"
    }

    $usedSlugs = @{}
    $count = 0

    for ($i = 0; $i -lt $ms.Count; $i++) {
        $m = $ms[$i]
        $title = $m.Groups['title'].Value.Trim()
        $dateIso = Convert-KoreanDateToIso $m.Groups['date'].Value

        $contentStart = $m.Index + $m.Length
        $contentEnd = if ($i + 1 -lt $ms.Count) { $ms[$i + 1].Index } else { $text.Length }
        $body = $text.Substring($contentStart, $contentEnd - $contentStart).Trim()

        if ([string]::IsNullOrWhiteSpace($body)) { continue }

        $slugBase = Convert-ToSlug $title
        $slug = $slugBase
        $n = 2
        while ($usedSlugs.ContainsKey($slug)) {
            $slug = "$slugBase-$n"
            $n++
        }
        $usedSlugs[$slug] = $true

        $fileNamePrefix = if ($dateIso) { "$dateIso-$slug" } else { $slug }
        $pageAssetsDir = Join-Path $sectionOut (Join-Path "assets" $slug)

        # 본문에서 사용된 이미지 찾아서 assets로 복사, 경로 재작성
        $imgPattern = '<img\s+src="([^"]+)"[^>]*/?>'
        $body = [regex]::Replace($body, $imgPattern, {
            param($match)
            $srcPath = $match.Groups[1].Value
            $srcPath = $srcPath -replace '/', '\'
            if (-not (Test-Path $srcPath)) {
                $pngGuess = [IO.Path]::ChangeExtension($srcPath, "png")
                if (Test-Path $pngGuess) { $srcPath = $pngGuess } else { return "" }
            }
            New-Item -ItemType Directory -Force -Path $pageAssetsDir | Out-Null
            $imgName = Split-Path $srcPath -Leaf
            $destPath = Join-Path $pageAssetsDir $imgName
            Copy-Item $srcPath $destPath -Force
            return "![](assets/$slug/$imgName)"
        })

        $tagsYaml = "[erp, 개발, $sectionName]"
        $frontmatter = @"
---
title: $title
date: $dateIso
tags: $tagsYaml
---

# $title

$body
"@

        $outFile = Join-Path $sectionOut ("$fileNamePrefix.md")
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($outFile, $frontmatter, $utf8NoBom)
        $count++
    }

    Write-Host "  -> $count 개 노트 생성 완료 ($sectionOut)" -ForegroundColor Green
}

Write-Host "`n전체 변환 완료." -ForegroundColor Yellow
