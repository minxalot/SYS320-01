clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show configuration`n"
$Prompt += "2 - Change configuration`n"
$Prompt += "3 - Exit`n"

$operation = $true

$configFile = Get-Content C:\Users\champuser\SYS320-01\week7
$configParams = @()

function readConfig() {
    
}

function changeConfig() {
    
}

function configMenu() {
    while ($operation) {
        Write-Host $Prompt | Out-String
        $choice = Read-Host

        if ($choice -eq 3) {
            Write-Host "Exiting" | Out-String
            exit
            $operation = $false
        }

        elseif ($choice -eq 1) {
        
        }

        elseif ($choice -eq 2) {
   
        }

        else {
            Write-Host "Invalid." | Out-String
        }
    }
}

configMenu