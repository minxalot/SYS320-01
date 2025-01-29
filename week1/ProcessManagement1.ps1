# 1
$processes = Get-Process | Where-Object { $_.ProcessName -like "C*" }

$processes | Format-Table ProcessName

# 2
$processes = Get-Process | Where-Object { 
    $_.Path -and $_.Path -notlike "*system32*"
}

$processes | Format-Table Id, ProcessName, Path -AutoSize

# 3
# I AM NOT RUNNING THIS ON WINDOWS XP. My personal Windows installation has some
# purely cosmetic hacks applied to it. I couldn't finish this in class and didn't
# realize that I hadn't set up remote desktop properly, so I'm doing this on my own
# computer. Hope that's okay!
$outputFile = "$PSScriptRoot\stopped_services.csv"

$stoppedServices = Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object Name
$stoppedServices | Select-Object Name | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "done."

# 4
$instances = Get-WmiObject Win32_Process -Filter "Name='powershell.exe' AND CommandLine LIKE '%ProcessManagement.ps1%'"

if ($instances.Count -gt 1) {
    "nah"
    exit
}
else {
    Write-Host "opening chrome rn"
    Start-Process "chrome.exe" -ArgumentList "https://champlain.edu"
}