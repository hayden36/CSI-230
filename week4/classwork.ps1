## 3. Get all logs
#cls
#Get-Content .\access.log

##4.
#cls
#Get-Content .\access.log -Tail 5

##5. Display only 404s or 400s
#cls
#Get-Content .\access.log | Select-String -Pattern '404', '400'

##6. Only get NOT 200s
#cls
#Get-Content .\access.log | Select-String -Pattern '200' -NotMatch

##7. Only get logs that have the word "error"
#cls
#$A = Get-ChildItem .\*.log | Select-String -Pattern 'error'
#$A[5..1]

#8. Display only IP for 404s
cls
cd C:\xampp\apache\logs
$notFounds = Get-Content .\access.log | Select-String -Pattern '404'

$regex = [regex] "\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}"

$ipsUnorg = $regex.Matches($notFounds)

$ips = @()
for ($i=0; $i -lt $ipsUnorg.Count; $i++) {
    $ips += [pscustomobject]@{"IP" = $ipsUnorg[$i].Value;}
}
#$ips | Where-Object {$_.IP -ilike "10.*"}

#9. Get $ips from 8.
cls
$ipsoften = $ips | Where-Object {$_.IP -ilike "10.*"}
$counts = $ipsoften | Group-Object IP
$counts | Select-Object Count, Name



## Parsing Logs Assignment
#. (Join-Path $PSScriptRoot ParseApacheLogs.ps1)
#cls
#$parseLogs = Parse-Logs
#$parseLogs | Ft -AutoSize -Wrap
