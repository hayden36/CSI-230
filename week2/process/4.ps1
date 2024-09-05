$chrome_proc = Get-Process | Where-Object {$_.Name -ilike "*Chrome*"}
if ($chrome_proc) {
    Write-Host "Chrome is already running. Stopping."
   $chrome_proc | Stop-Process
} else {
    Start-Process -FilePath Chrome -ArgumentList "https://champlain.edu"
}