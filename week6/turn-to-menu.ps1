. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)


# Functions
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


# Main logic
clear


$inLoop = $true
$choice = $null
$options = "`n"
$options += "1. Display last 10 apache logs. `n"
$options += "2. Display last 10 failed logins for all users. `n"
$options += "3. Display at-risk users. `n"
$options += "4. Start chrome and open champlain.edu. `n"
$options += "5. Exit.`n"

while ($inLoop) {
    Write-Host "Please choose an option: "
    Write-Host $options
    $choice = Read-Host
    if ($choice -eq 1) {
        $records = Parse-ApacheLogs | Format-Table
        $records
    }
    elseif ($choice -eq 2) {
        # Display failed logins
        # TODO
    }
    elseif ($choice -eq 3) {
        # At-risk users
        $userLogins = getFailedLogins $days 
        $userlogins = $userlogins | Group-Object User | Select-Object Name, Count, Time | Where-Object { $_.Count -gt 10 }
        $userLogins | Format-Table -AutoSize -Wrap
    }
    elseif ($choice -eq 4) {
        $chrome_proc = Get-Process | Where-Object { $_.Name -ilike "*Chrome*" }
        if ($chrome_proc) {
            Write-Host "Chrome is already running. Stopping."
            Stop-Process -name "chrome"
        }
        else {
            Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" "https://champlain.edu"
        }
    }

    elseif ($choice -eq 5) {
        $choice = $null
        $inLoop = $false
        exit
    }
    else {
        Write-Host "Invalid option selected.`n"
    }

}


