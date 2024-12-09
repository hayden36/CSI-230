$PSScriptRoot = "C:\Users\champuser\CSI-230\week7"
. (Join-Path $PSScriptRoot .\Configutation.ps1)
. (Join-Path $PSScriptRoot .\Email.ps1)
. (Join-Path $PSScriptRoot .\Scheduler.ps1)
. (Join-Path $PSScriptRoot .\Event-Logs.ps1)


$configuration = readConfiguration
$users = getFailedLogins($configuration.Days)

SendAlertEmail($users | Format-Table | Out-String)


ChooseTimeToRun($configuration.Time)