﻿function SendAlertEmail($Body) {
    
    $From = "lindsey.bellaire@mymail.champlain.edu"
    $To = "lindsey.bellaire@mymail.champlain.edu"
    $Subject = "Suspicious activity"

    $Password = "lsgt nxlp tqvo jwqk
    " | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
}

SendAlertEmail "Body of email"