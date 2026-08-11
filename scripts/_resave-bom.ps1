param([string]$Path)
$c = Get-Content -Raw -Encoding UTF8 $Path
[System.IO.File]::WriteAllText($Path, $c, (New-Object System.Text.UTF8Encoding($true)))
Write-Host "BOM 재저장 완료: $Path"
