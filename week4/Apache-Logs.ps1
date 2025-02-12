$logFile = Get-Content -Path C:\xampp\apache\logs\access.log

$logEntries = Get-Content -Path $logFile | Select-String "\s$HttpCode\s"

$regex = [regex] "\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\b"

# i struggled with this. instructions on canvas seem slightly unclear