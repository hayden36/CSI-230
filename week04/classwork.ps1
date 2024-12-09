# 3. Get all logs
Get-Content .\access.log

#4.
Get-Content .\access.log -Tail 5

#5. Display only 404s or 400s
Get-Content .\access.log | Select-String -Pattern '404', '400'

#6. Only get NOT 200s
Get-Content .\access.log | Select-String -Pattern '200' -NotMatch

#7. Only get logs that have the word "error"
$A = Get-ChildItem .\*.log | Select-String -Pattern 'error'
$A[5..1]

#8. Display only IP for 404s
cd C:\xampp\apache\logs
$notFounds = Get-Content .\access.log | Select-String -Pattern '404'

$regex = [regex] "\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}"

$ipsUnorg = $regex.Matches($notFounds)

$ips = @()
for ($i=0; $i -lt $ipsUnorg.Count; $i++) {
    $ips += [pscustomobject]@{"IP" = $ipsUnorg[$i].Value;}
}
$ips | Where-Object {$_.IP -ilike "10.*"}

#9. Get $ips from 8.
$ipsoften = $ips | Where-Object {$_.IP -ilike "10.*"}
$counts = $ipsoften | Group-Object IP
$counts | Select-Object Count, Name

# Functions
. (Join-Path "C:\Users\champuser\CSI-230\week4" Apache-Logs.ps1)
ApacheLogs1 -page "/" -httpCode 200 -browserName "Firefox"


# Parsing Apache Logs
. (Join-Path "C:\Users\champuser\CSI-230\week4" ParseApacheLogs.ps1)
Parse-ApacheLogs | Ft -AutoSize -Wrap