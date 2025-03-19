function ApacheLogs(){

$logsNotFormatted = Get-Content C:\Users\champuser\SYS320-01\midterm\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotFormatted.Count; $i++) {

    $words = $logsNotFormatted[$i] -split " "

      $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                          "Time" = $words[3].Trim('['); `
                                          "Method" = $words[5].Trim('"'); `
                                          "Page" = $words[6]; `
                                          "Protocol" = $words[7]; `
                                          "Response" = $words[8]; `
                                          "Referrer" = $words[10]; `
                                          }
              
}
    Write-Output $tableRecords | Where-Object { $_.IP -like "10.*" }
}

function Filter-ApacheLogs {
    param ( [string[]]$indicators )

    $logsNotFormatted = Get-Content C:\Users\champuser\SYS320-01\midterm\access.log
    $tableRecords = @()

    foreach ($log in $logsNotFormatted) {
        $words = $log -split " "
        
        if ($words.Count -lt 9) { continue }
        
        $record = [PSCustomObject]@{
            "IP"        = $words[0]
            "Time"      = $words[3].Trim('[')
            "Method"    = $words[5].Trim('"')
            "Page"      = $words[6]
            "Protocol"  = $words[7]
            "Response"  = $words[8]
            "Referrer"  = $words[10]
        }

        foreach ($indicator in $indicators) {
            if ($record.Page -like "*$indicator*") {
                $tableRecords += $record
                break
            }
        }
    }

    Write-Output $tableRecords
}

$indicators = @("cmd=etc/passwd", "cmd=/bin/bash", "OR+1=1", "reverseshell.bash")

Filter-ApacheLogs -indicators $indicators