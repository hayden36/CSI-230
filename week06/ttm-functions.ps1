
function getFailedLoginsRecent {
  
    $failedlogins = Get-EventLog security -InstanceId 4625 -Newest 10 

    $failedloginsTable = @()
    for ($i = 0; $i -lt $failedlogins.Count; $i++) {

        $account = ""
        $domain = "" 

        $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
        $usr = $usrlines[1].Split(":")[1].trim()

        $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
        $dmn = $dmnlines[1].Split(":")[1].trim()

        $user = $dmn + "\" + $usr;

        $failedloginsTable += [pscustomobject]@{`
                "Time" = $failedlogins[$i].TimeGenerated; `
                "User" = $user;
        }

    }

    return $failedloginsTable
} # End of function getFailedLogins


function getFailedLogins($timeBack) {
  
    $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-" + "$timeBack") | Where { $_.InstanceID -eq "4625" }

    $failedloginsTable = @()
    for ($i = 0; $i -lt $failedlogins.Count; $i++) {

        $account = ""
        $domain = "" 

        $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
        $usr = $usrlines[1].Split(":")[1].trim()

        $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
        $dmn = $dmnlines[1].Split(":")[1].trim()

        $user = $dmn + "\" + $usr;

        $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                "Id"                                   = $failedlogins[$i].InstanceId; `
                "Event"                                = "Failed"; `
                "User"                                 = $user;
        }

    }

    return $failedloginsTable
} # End of function getFailedLogins



function Parse-ApacheLogs {
    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for ($i = 0; $i -lt $logsNotFormatted.Length; $i++) {
        $words = $logsNotFormatted[$i].Split(" ")
        $tableRecords += [pscustomobject]@{"IP" = $words[0]; `
                "Time"                          = $words[3].Trim('['); `
                "Method"                        = $words[5].Trim('"'); `
                "Page"                          = $words[6]; `
                "Protocol"                      = $words[7]; `
                "Response"                      = $words[8]; `
                "Referer"                       = $words[10]; `
                "Client"                        = $words[11..($words.Length)]; 
        }

    }
    return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}