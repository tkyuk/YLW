$notesRoot = "C:\WorkSpace\AI\notes\erp-개발"
$mdFiles = Get-ChildItem $notesRoot -Recurse -Filter "*.md"
$missing = 0
$checked = 0
foreach ($f in $mdFiles) {
    $dir = $f.DirectoryName
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $matches = [regex]::Matches($content, '!\[\]\((assets/[^)]*?\.(?:png|jpg|jpeg|gif|bmp|wmf|emf))\)')
    foreach ($m in $matches) {
        $checked++
        $imgRel = $m.Groups[1].Value
        $imgPath = Join-Path $dir $imgRel
        if (-not (Test-Path -LiteralPath $imgPath)) {
            Write-Output "MISSING: $($f.FullName) -> $imgRel"
            $missing++
        }
    }
}
Write-Output "`n총 이미지 참조: $checked, 누락: $missing"
