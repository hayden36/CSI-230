function SendAlertEmail($body) {
    $From = Read-Host "Enter email"
    $To = $From

    $Subject = "Suspicious Activity"

    $Password = Read-Host "Enter account password" -AsSecureString
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
}