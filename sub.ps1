$a = [System.Environment]::GetFolderPath('Desktop')
$b = Join-Path -Path $a -ChildPath "TASK_RUN_SUCCESSFULLY.PS1"
New-Item -Path $b -ItemType File -Force
Exit-PSHostProcess