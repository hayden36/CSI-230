function ApacheLogs1($page, $httpCode, $browserName) {
    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    echo $page;
    for ($i=0; $i -lt $logsNotFormatted.Length; $i++) {
        $words = $logsNotFormatted[$i].Split(" ")
        $tableRecords += [pscustomobject]@{"IP" = $words[0]; `
                                           "Time" = $words[3].Trim('['); `
                                           "Method" = $words[5].Trim('"'); `
                                           "Page" = $words[6]; `
                                           "Protocol" = $words[7]; `
                                           "Response" = $words[8]; `
                                           "Referer" = $words[10]; `
                                           "Client" = $words[11..($words.Length)] -join ' '; }

    }
    return $tableRecords | Where-Object {$_.IP -ilike "10.*" }
   }