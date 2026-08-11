$ErrorActionPreference = "Stop"

$TaskName = "OneNote-YLW-Sync"
$ScriptPath = "C:\WorkSpace\AI\scripts\sync-onenote.ps1"

$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`"" `
    -WorkingDirectory "C:\WorkSpace\AI"

$trigger = New-ScheduledTaskTrigger -Daily -At 9:00AM

$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Limited

$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopOnIdleEnd -ExecutionTimeLimit (New-TimeSpan -Hours 1)

if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Description "OneNote 로컬 노트북(YLW_Tgkim) 변경분을 매일 감지해서 git 저장소(notes/erp-개발)에 자동 동기화" | Out-Null

Write-Host "작업 등록 완료: $TaskName"
Get-ScheduledTask -TaskName $TaskName | Format-List TaskName, State
Get-ScheduledTaskInfo -TaskName $TaskName | Format-List NextRunTime, LastRunTime
