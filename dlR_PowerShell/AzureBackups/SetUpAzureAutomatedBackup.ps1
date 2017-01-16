#
# SetUpAzureAutomatedBackup.ps1
#

$storageaccount = "sgapp001"
$storageaccountkey = (Get-AzureStorageKey -StorageAccountName $storageaccount).Primary
$storagecontext = New-AzureStorageContext -StorageAccountName $storageaccount -StorageAccountKey $storageaccountkey
# $password = "P@ssw0rd"
$encryptionpassword = $password | ConvertTo-SecureString -AsPlainText -Force  
$autobackupconfig = New-AzureVMSqlServerAutoBackupConfig -StorageContext $storagecontext -Enable -RetentionPeriod 10 -EnableEncryption -CertificatePassword $encryptionpassword

Get-AzureVM -ServiceName SG-AZ-APP-001 -Name SG-AZ-APP-001 | Set-AzureVMSqlServerExtension -AutoBackupSettings $autobackupconfig | Update-AzureVM