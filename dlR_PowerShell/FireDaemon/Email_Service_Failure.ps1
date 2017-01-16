param([string]$message="FireDaemon Process Failed")
$EmailFrom = “isemail@signalgenetics.com”
$EmailTo = “pdelosreyes@signalgenetics.com”
$Subject = “FireDaemon Process Failure”
$Body = $message
$SMTPServer = “smtp.office365.com”
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential(“isemail@signalgenetics.com”, “V6x0OEFj6c2H6f4k”);
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
