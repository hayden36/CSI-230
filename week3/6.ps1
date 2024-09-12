. (Join-Path $PSScriptRoot 1-5.ps1)
clear

$loginoutsTable = Get-LoginLogoutEvents(15)
$loginoutsTable

$shutdownsTable = Get-StartAndShutdownTimes(25)
$shutdownsTable