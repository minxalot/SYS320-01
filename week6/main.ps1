. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot String-Helper.ps1)

# clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At Risk Users`n"
$Prompt += "10 - Exit`n"

$operation = $true

function checkUser($name) {
    $userExists = Get-LocalUser | Where-Object { $_.Name -ilike $name }
    return $userExists
}

function checkPassword($password) {

    if ($password.Length -lt 6) {
        Write-Host "Password must be at least 6 characters long."
        return $false
    }
    if ($password -notmatch '\d') {
        Write-Host "Password must contain at least 1 number."
        return $false
    }
    if ($password -notmatch '[A-Za-z]') {
        Write-Host "Password must contain at least 1 letter."
        return $false
    }
    if ($password -notmatch '[!@#$%^&*(),.?":{}|<>]') {
        Write-Host "Password must contain at least 1 special character."
        return $false
    }
    return $true
}

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
    elseif ($choice -eq 3) {
        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user:"
        
        # Check if the user already exists
        if (checkUser $name) {
            Write-Host "User already exists. Please choose a different username." | Out-String
            continue
        }

        if (-not (checkPassword $password)) {
            continue
        }

        createAUser $name $password
        Write-Host "User: $name is created." | Out-String
    }
    elseif ($choice -eq 4) {
        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if (-not (checkUser $name)) {
            Write-Host "User does not exist." | Out-String
            continue
        }

        removeAUser $name
        Write-Host "User: $name Removed." | Out-String
    }
    elseif ($choice -eq 5) {
        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if (-not (checkUser $name)) {
            Write-Host "User does not exist." | Out-String
            continue
        }

        enableAUser $name
        Write-Host "User: $name Enabled." | Out-String
    }
    elseif ($choice -eq 6) {
        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if (-not (checkUser $name)) {
            Write-Host "User does not exist." | Out-String
            continue
        }

        disableAUser $name
        Write-Host "User: $name Disabled." | Out-String
    }
    elseif ($choice -eq 7) {
        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if (-not (checkUser $name)) {
            Write-Host "User does not exist." | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days for log retrieval"
        $userLogins = getLogInAndOffs $days
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name" } | Format-Table | Out-String)
    }
    elseif ($choice -eq 8) {
        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if (-not (checkUser $name)) {
            Write-Host "User does not exist." | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days for failed logins"
        $userLogins = getFailedLogins $days
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name" } | Format-Table | Out-String)
    }
    elseif ($choice -eq 9) {
        $days = Read-Host -Prompt "Please enter the number of days for checking failed logins"
        $failedLogins = getFailedLogins $days
        $usersAtRisk = $failedLogins | Group-Object User | Where-Object { $_.Count -gt 10 }

        if ($usersAtRisk) {
            Write-Host "Users at risk:" | Out-String
            Write-Host ($usersAtRisk | Format-Table | Out-String)
        } else {
            Write-Host "No users at risk." | Out-String
        }
    }
    else {
        Write-Host "Womp womp. You messed up. Try again." | Out-String
    }
}