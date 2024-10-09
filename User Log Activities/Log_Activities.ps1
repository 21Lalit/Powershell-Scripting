# Set up log file paths
$logPath = "C:\UserActivityLogs"
if (-not (Test-Path $logPath)) {
    New-Item -Path $logPath -ItemType Directory
}

$loginLogoutLog = "$logPath\LoginLogoutLogs.txt"
$processLog = "$logPath\RunningProcesses.txt"
$activeWindowLog = "$logPath\ActiveWindowLogs.txt"
$consolidatedLog = "$logPath\ConsolidatedUserActivityLog.txt"

# 1. Monitor Login and Logout Times
Write-Host "Logging login and logout times..."

$loginLogoutEvents = Get-EventLog -LogName Security -InstanceId 4624, 4634 | 
    Select-Object TimeGenerated, EntryType, Message
$loginLogoutEvents | Out-File $loginLogoutLog

Write-Host "Login and logout events saved to $loginLogoutLog"

# 2. Track Running Processes
Write-Host "Logging running processes..."

$runningProcesses = Get-Process | 
    Select-Object Name, Id, StartTime
$runningProcesses | Out-File $processLog

Write-Host "Running processes saved to $processLog"

# 3. Monitor Active Window
Write-Host "Logging active window..."

$activeWindow = (Get-Process | Where-Object {$_.MainWindowTitle -ne ""}).MainWindowTitle
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$activeWindowLogEntry = "$timestamp : $activeWindow"
$activeWindowLogEntry | Out-File -Append $activeWindowLog

Write-Host "Active window saved to $activeWindowLog"

# 4. Consolidate Logs
Write-Host "Consolidating logs..."

Get-Content $loginLogoutLog, $processLog, $activeWindowLog | 
    Out-File $consolidatedLog

Write-Host "All logs consolidated into $consolidatedLog"

# Optional: Set up a scheduled task to run this script periodically
# Uncomment the below code to register the script in Windows Task Scheduler
# $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-File `"$PSCommandPath`""
# $trigger = New-ScheduledTaskTrigger -AtStartup -Once -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration ([TimeSpan]::MaxValue)
# Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "UserActivityMonitor" -Description "Monitor user activities (login/logout, processes, active window)"
