# 이미 수동으로 임포트된 섹션들은 "오늘 기준 이미 동기화됨"으로 baseline 상태를 만든다.
# notes/erp-개발/<섹션명> 폴더가 이미 존재하는 섹션의 페이지만 baseline으로 기록하고,
# 폴더가 없는 새 섹션은 기록하지 않아서 다음 sync 실행 시 새로 처리되게 한다.
$ErrorActionPreference = "Stop"

$Root      = "C:\WorkSpace\AI"
$NotesRoot = Join-Path $Root "notes\erp-개발"
$StatePath = Join-Path $Root "_onenote-export\sync-state.json"

$onenote = New-Object -ComObject OneNote.Application
$xmlStr = ""
$onenote.GetHierarchy("", [Microsoft.Office.Interop.OneNote.HierarchyScope]::hsPages, [ref]$xmlStr)
[xml]$h = $xmlStr
$ns = New-Object System.Xml.XmlNamespaceManager($h.NameTable)
$ns.AddNamespace("one", "http://schemas.microsoft.com/office/onenote/2013/onenote")

$stateMap = @{}
$seededSections = @()
$skippedSections = @()

function Seed-Node($node) {
    $sections = $node.SelectNodes("one:Section", $ns)
    foreach ($sec in $sections) {
        $folder = Join-Path $NotesRoot $sec.name
        if (Test-Path -LiteralPath $folder) {
            $pages = $sec.SelectNodes("one:Page", $ns)
            foreach ($p in $pages) {
                $stateMap[$p.ID] = [PSCustomObject]@{
                    lastModifiedTime = $p.lastModifiedTime
                    file             = $null
                    assetsDir        = $null
                    sectionName      = $sec.name
                }
            }
            $script:seededSections += "$($sec.name) ($($pages.Count))"
        } else {
            $script:skippedSections += $sec.name
        }
    }
    $groups = $node.SelectNodes("one:SectionGroup", $ns)
    foreach ($g in $groups) {
        if ($g.name -eq "OneNote_RecycleBin") { continue }
        Seed-Node $g
    }
}

$notebooks = $h.SelectNodes("//one:Notebook", $ns)
foreach ($nb in $notebooks) { Seed-Node $nb }

($stateMap | ConvertTo-Json -Depth 5) | Out-File -FilePath $StatePath -Encoding utf8

Write-Host "Baseline 기록된 섹션:"
$seededSections | ForEach-Object { Write-Host "  - $_" }
Write-Host "`n이번에 새로 처리될 섹션(baseline 미기록):"
$skippedSections | ForEach-Object { Write-Host "  - $_" }
Write-Host "`n총 baseline 페이지 수: $($stateMap.Count)"
