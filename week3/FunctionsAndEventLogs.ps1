$days = Read-Host "How many days?"

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon  -After (Get-Date).AddDays(-$days)

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++) {

    $event = ""
    if($loginouts[$i].EventID -eq 7001) {$event = "Logon"}
    if($loginouts[$i].EventID -eq 7002) {$event = "Logoff"}

    $sid = $loginouts[$i].ReplacementStrings[1]
    $user = New-Object System.Security.Principal.SecurityIdentifier($sid)
    $username = $user.Translate([System.Security.Principal.NTAccount]).Value

    $loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                           "ID" = $loginouts[$i].EventID;
                                        "Event" = $event;
                                         "User" = $username;
                                        }
}

$loginoutsTable

$powerevents = Get-EventLog -LogName system -After (Get-Date).AddDays(-$days) | Where EventID -in 6005,6006

$powereventsTable = @()
for($i=0; $i -lt $powerevents.Count; $i++) {

    $event = ""
    if($powerevents[$i].EventID -eq 6005) {$event = "Startup"}
    if($powerevents[$i].EventID -eq 6006) {$event = "Shutdown"}

    if ($eventID -eq 6005 -or $eventID -eq 6006) {
        $event = if ($eventID -eq 6005) { "Startup" } else { "Shutdown" }
        }

    $powereventsTable += [PSCustomObject]@{"Time" = $powerevents[$i].TimeGenerated;
                                             "ID" = $powerevents[$i].EventID;
                                          "Event" = $event;
                                           "User" = "System";
                                          }
}

$powereventsTable