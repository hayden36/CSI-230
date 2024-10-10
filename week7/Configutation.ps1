function readConfiguration {
    $configurationContent = Get-Content .\configuration.txt
    # https://stackoverflow.com/questions/39252620/powershell-split-specify-a-new-line
    $configurationContent = $configurationContent.Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)
    $configurationObject = [pscustomobject]@{
        Days = $configurationContent[0];
        Time = $configurationContent[1];
    }
    $configurationObject  | Format-Table
}



function changeConfiguration {
    [int]$newDay = ""
    $daysValid = $false
    while ($daysValid -eq $false) {
        try {
            $newDay = Read-Host "Enter the number of days to look through"
            if ($newDay -lt 1) {
                Write-Host "The number of days must be greater than 0."
            }
            else {
                $daysValid = $true
            }
        }
        catch {
            Write-Host "Invalid format. Please enter a number."
        }
    }
    $timeValid = $false
    [string]$newTime = ""
    while ($timeValid -eq $false) {
        
        $newTime = Read-Host "Enter the time to execute. Please enter in the format H:MM AM/PM"
        if ($newTime -match '^[1-9]:[0-5][0-9] [AP]M$') {
            $timeValid = $true
        }
        
    }

    "$newDay`n$newTime" | Out-File .\configuration.txt
    Write-Host "Config changed."
}

function configurationMenu {
    $inLoop = $true

    $choices = ""
    $choices += "1. Show configuration.`n"
    $choices += "2. Change the configuration.`n"
    $choices += "3. Exit.`n"
    [int]$choice = -1

    while ($inLoop) {
        Write-Host $choices
        $choice = Read-Host "Select an option"
        if ($choice -eq 1) {
            readConfiguration
        }
        elseif ($choice -eq 2) {
            changeConfiguration
        }
        elseif ($choice -eq 3) {
            $inLoop = $false
            exit
        }
        else {
            Write-Host "Invalid option selected.`n"
        }
    }

}