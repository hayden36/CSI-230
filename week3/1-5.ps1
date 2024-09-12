# Question 1
Get-EventLog System -source Microsoft-Windows-Winlogon

# Question 2/3
$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginoutsTable = @()

for ($i=0; $i -lt $loginouts.Count; $i++) {
    $events = ""

    if ($loginouts[$i].EventID -eq 7001) {$event="Logon"} 
     if ($loginouts[$i].EventID -eq 7002) {$event="Logoff"} 
     
     $user = $loginouts[$i].ReplacementStrings[1]
     $SID = New-Object System.Security.Principal.SecurityIdentifier($user)
     $user = $SID.Translate([System.Security.Principal.NTAccount]).Value

    

     $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                            "Id" = $loginouts[$i].EventID; `
                                             "Event" =$event; `
                                            "User" = $user;
                                            }
}
$loginoutsTable | Format-Table -AutoSize -Wrap

# Question 4
function Get-LoginLogoutEvents($daysToGet) {
Write-Host "Getting login/logout events for the past $daysToGet day(s)."
$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$daysToGet)
$loginoutsTable = @()

for ($i=0; $i -lt $loginouts.Count; $i++) {
    $events = ""

    if ($loginouts[$i].EventID -eq 7001) {$event="Logon"} 
     if ($loginouts[$i].EventID -eq 7002) {$event="Logoff"} 
     
     $user = $loginouts[$i].ReplacementStrings[1]
     $SID = New-Object System.Security.Principal.SecurityIdentifier($user)
     $user = $SID.Translate([System.Security.Principal.NTAccount]).Value

    

     $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                            "Id" = $loginouts[$i].EventID; `
                                             "Event" =$event; `
                                            "User" = $user;
                                            }
}
$loginoutsTable | Format-Table -AutoSize -Wrap
}

        

Get-LoginLogoutEvents(2)



# Question 5
function Get-StartAndShutdownTimes($days) {
Write-Host "Question 5: Getting start & shutdown events from the past $days day(s)."
$loginouts = Get-EventLog System -After (Get-Date).AddDays(-$days)
$loginoutsTable = @()

for ($i=0; $i -lt $loginouts.Count; $i++) {
    $events = ""

    if ($loginouts[$i].EventID -eq 6005) {$event="Start"} 
    elseif ($loginouts[$i].EventID -eq 6006) {$event="Shutdown"}
    else {continue}
     
     $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                           "Id" = $loginouts[$i].EventID; `
                                           "Event" = $event; `
                                           "User" = "System";
                                         }
    }
$loginoutsTable | Format-Table -AutoSize -Wrap
}

Get-StartAndShutdownTimes