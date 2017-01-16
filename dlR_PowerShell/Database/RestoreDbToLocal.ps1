#
# Script.ps1
#

Write-Host "Hello world"

## PARAMETERS ####################################################

#local working directory to copy files into 
$LocalTempDir = "C:\Temp\SgnlPowerShell-RestoreDbToLocal"

#base directory that contains the database backups 
$RemoteDbDirBase = "\\sg-ca01-nas-001\Department\Shared_IS\SoftwareDevelopment\DatabaseStaging\SG-AZ-APP-001"

##################################################################


function Restore-Database( $DatabaseName )
{	
	$PathToBackupFile = $RemoteDbDirBase + "\" + $DatabaseName
	

	#Copy latest .bak file into the temporary directory
	$LatestBakFile = Get-ChildItem "*.bak" -Path $PathToBackupFile | Where-Object -FilterScript { $_ -notlike "*_log.bak" }  | Sort-Object CreationTime -Descending | Select-Object -First 1  
	Write-Host "Copying " $LatestBakFile.FullName " ..."
	Copy-Item $LatestBakFile.FullName $LocalTempDir
	Write-Host "Finished."

	# This part not working yet -DT
	##Restore DB	
	#$FullBackupPath = $LocalTempDir+"\"+$LatestBakFile.Name
	#Write-Host "Restoring database " $FullBackupPath " ..."
	#Restore-SqlDatabase -ServerInstance localhost -Database $DatabaseName -BackupFile $FullBackupPath -ReplaceDatabase
	#Write-Host "Finished."
}


#create temp directory if it does not exist (Will not delete existing files if they exist.)
New-Item -ItemType Directory -Force -Path $LocalTempDir


#copy latest database backup files into temp folder 
$DatabaseList = @(
 	 ("SGNL_LIS")
	,("SGNL_FINANCE")
	,("SGNL_INTERNAL")
	,("SGNL_WAREHOUSE")
	,("XifinLIS")
)

foreach ($Db in $DatabaseList)
{
	Restore-Database $Db
}

Write-Host "Process Complete"
