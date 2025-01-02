

# Function to create a scheduled task
Function Create-ScheduledTask {
    $taskName = Read-Host "Enter the task name"
    $programPath = Read-Host "Enter the full path of the program (or script) to run"

    # Define the trigger options
    $triggerOptions = @("At Logon", "Daily", "Weekly", "One Time")
    Write-Host "Select a trigger:"
    $triggerOptions | ForEach-Object { Write-Host "$($_) - $($_)" }
    $triggerChoice = Read-Host "Choose a trigger"

    # Set up the trigger based on user choice
    $trigger = $null
    switch ($triggerChoice) {
        'At Logon' { $trigger = New-ScheduledTaskTrigger -AtLogOn }
        'Daily' {
            $startTime = Read-Host "Enter start time (HH:mm)"
            $trigger = New-ScheduledTaskTrigger -Daily -At $startTime
        }
        'Weekly' {
            $startTime = Read-Host "Enter start time (HH:mm)"
            $daysOfWeek = Read-Host "Enter days of week to run (e.g., Sunday,Monday)"
            # TODO: Implement weekly trigger setting
        }
        'One Time' {
            $runDate = Read-Host "Enter run date (YYYY-MM-DD)"
            $runTime = Read-Host "Enter run time (HH:mm)"
            # TODO: Implement one-time trigger setting
        }
        default { Write-Host "Invalid trigger choice."; return }
    }

    # Configure settings for the task
    $action = New-ScheduledTaskAction -Execute $programPath
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

    # Register the task
    # TODO: Implement task registration
}

# Function to show existing scheduled tasks
Function Show-ScheduledTasks {
    $tasks = Get-ScheduledTask | Select-Object TaskName, State, NextRunTime, LastRunTime
    if ($tasks.Count -eq 0) {
        Write-Host "No scheduled tasks found."
    } else {
        $tasks | Format-Table -AutoSize
    }
}

# Function to modify an existing scheduled task
Function Modify-ScheduledTask {
    $taskName = Read-Host "Enter the name of the task to modify"
    $task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

    if ($null -eq $task) {
        Write-Host "Task '$taskName' not found."
        return
    }

    $newProgramPath = Read-Host "Enter the new program path (leave blank to keep the same)"
    if ($newProgramPath) {
        # TODO: Implement action update for the task
    } else {
        Write-Host "Task action not updated."
    }

    # TODO: Implement trigger modification logic
}

# Function to remove a scheduled task
Function Remove-ScheduledTask {
    $taskName = Read-Host "Enter the name of the task to delete"
    # TODO: Implement task deletion
}

# Function to check the status of a scheduled task
Function Check-TaskStatus {
    $taskName = Read-Host "Enter the name of the task to check the status"
    $task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

    if ($null -eq $task) {
        Write-Host "Task '$taskName' not found."
        return
    }

    $status = $task.State
    Write-Host "The status of '$taskName' is: $status"
}

# Function to export the task list to CSV
Function Export-TaskList {
    $outputFile = Read-Host "Enter the output file path (e.g., C:\ScheduledTasks.csv)"
    $tasks = Get-ScheduledTask | Select-Object TaskName, State, NextRunTime, LastRunTime

    # Export to CSV
    try {
        # TODO: Implement CSV export functionality
    } Catch {
        Write-Host "Failed to export task list. Error: $_"
    }
}

# Main function to display the menu and handle user input
Function Main {
    while ($true) {
        Write-Host "== Scheduled Tasks Automation =="
        Write-Host "1. Create Scheduled Task"
        Write-Host "2. View Scheduled Tasks"
        Write-Host "3. Modify Scheduled Task"
        Write-Host "4. Delete Scheduled Task"
        Write-Host "5. Check Task Status"
        Write-Host "6. Export Task List"
        Write-Host "7. Exit"
        $choice = Read-Host "Select an option (1-7)"

        switch ($choice) {
            1 { Create-ScheduledTask }
            2 { Show-ScheduledTasks }
            3 { Modify-ScheduledTask }
            4 { Remove-ScheduledTask }
            5 { Check-TaskStatus }
            6 { Export-TaskList }
            7 { exit }
            default { Write-Host "Invalid choice! Please select again." }
        }
    }
}

# Start the main function
Main