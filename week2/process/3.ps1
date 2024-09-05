Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object | Export-Csv "3-out.csv"
