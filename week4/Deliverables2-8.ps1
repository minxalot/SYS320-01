$notfounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 '

$regex = [regex] "\b(\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3})\b"

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()

for($i=0; $i -lt $ipsUnorganized.Count; $i++) {
    $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name