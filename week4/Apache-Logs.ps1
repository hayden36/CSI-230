function ApacheLogs1 {
    param(
        [string]$page,
        [int]$httpCode,
        [string]$browserName
    )

    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for ($i=0; $i -lt $logsNotFormatted.Length; $i++) {
        $words = $logsNotFormatted[$i].Split(" ")
        $tableRecords += [pscustomobject]@{"IP" = $words[0]; `
                                           "Time" = $words[3].Trim('['); `
                                           "Method" = $words[5].Trim('"'); `
                                           "Page" = $words[6]; `
                                           "Protocol" = $words[7]; `
                                           "Response" = $words[8]; `
                                           "Referer" = $words[10]; `
                                           "Client" = $words[11..($words.Length)]; }

    }
    $tableRecords = $tableRecords | Where-Object {$_.Page -ilike "*$page*" -and $_.Response -eq $httpCode -and $_.Client -ilike "*$browserName*"}
  

    $counts = $tableRecords | Group-Object IP
    return $counts | Select-Object Name
   }

