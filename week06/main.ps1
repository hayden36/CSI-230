. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at-risk users`n"
$Prompt += "10 - Exit`n"


$operation = $true

while ($operation) {

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if ($choice -eq 10) {
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif ($choice -eq 1) {
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif ($choice -eq 2) {
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif ($choice -eq 3) { 
        $name = Read-Host -Prompt "Please enter the username for the new user"
        
        $chkUser = checkuser $name
        if ($chkUser -ne $true) {
            
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

            $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $plainpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

            $chkPassword = checkPassword $plainpassword

            if ($chkPassword -ne $false) {
                createAUser $name $password
                Write-Host "User: $name is created." | Out-String
            }
            else {
                Write-Host "Password does not meet requirements" | Out-String
            }
            
        }
        else {
            Write-Host "User $name already exists." | Out-String
        }
    }

    # Remove a user
    elseif ($choice -eq 4) {
        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $chkUser = checkuser $name
        if ($chkUser -eq $true) {
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else {
            Write-Host "User does not exist or could not remove user."
        }
    }

    # Enable a user
    elseif ($choice -eq 5) {
        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if (checkUser $name -eq $true) {
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else {
            Write-Host "User does not exist or could not enable user."
        }
    }

    # Disable a user
    elseif ($choice -eq 6) {
        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if (checkUser $name -eq $true) {
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else {
            Write-Host "User does not exist or could not disable user."
        }
    }
    elseif ($choice -eq 7) {
        $name = Read-Host -Prompt "Please enter the username for the user logs"
        $days = Read-Host -Prompt "How many days would you like to search?"

        if (checkUser $name -eq $true) {
            $userLogins = getLogInAndOffs $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name" } | Format-Table | Out-String)
        }
        else {
            Write-Host "User does not exist or could not read logs for this user."
        }
    }
    elseif ($choice -eq 8) {
        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
        $days = Read-Host -Prompt "How many days would you like to search?"
        if (checkUser $name -eq $true) {
            $userLogins = getFailedLogins $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name" } | Format-Table | Out-String)
        }
        else {
            Write-Host "User does not exist or could not read logs for this user."
        }

    }
    elseif ($choice -eq 9) {
        $days = Read-Host "How many days would you like to search?"
        $userLogins = getFailedLogins $days 
        $userlogins = $userlogins | Group-Object User | Select-Object Name, Count | Where-Object { $_.Count -gt 10 }
        $userLogins | Format-Table -AutoSize -Wrap
     
    }
    else {
        Write-Host "You entered an invalid option. Please try again."
    }
    

}




