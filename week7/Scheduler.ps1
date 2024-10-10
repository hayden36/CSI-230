function ChooseTimeToRun($Time) {
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "mytask" }
    if ($scheduledTasks -ne $null) {
        Write-Host "The tasks exists."
        DisableAutoRun
    }

    Write-Host "Creating new task."
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -argument "-File `"C:\Users\champuser\CSI-230\week7\main.ps1`""
    $trigger = New-ScheduledTaskTrigger -Daily -At $Time
    $principal = New-ScheduledTaskPrincipal -Userid "champuser" -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings

    Register-ScheduledTask 'myTask' -InputObject $task
    Get-ScheduledTask | Where-Object { $_.TaskName -ilike "mytask" }
}

function DisableAutoRun() {
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "mytask" }

    if ($scheduledTasks -ne $null) {
        Write-Host "Unregisterting the task"
        Unregister-ScheduledTask -TaskName 'myTask' -Confirm:$false
    }
    else {
        Write-Host "Task not registered."
    }
}