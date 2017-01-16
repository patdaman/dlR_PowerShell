#
# RestoreDatabase.ps1
#

# Set SQL Server instance name
$sqlName= "SG-CA01-DVM-002"

# Set new or existing database name to restore backup
$dbname= "SGNL_WAREHOUSE"

# Set the existing backup file path
$backupPath= "D:\SQLBackup\MorganDB.bak"

#Load the required assemlies SMO and SmoExtended.
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null 

# Connect SQL Server.
$sqlServer = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $sqlName

# Create SMo Restore object instance
$dbRestore = new-object ("Microsoft.SqlServer.Management.Smo.Restore")

# Set database and backup file path
$dbRestore.Database = $dbname
$dbRestore.Devices.AddDevice($backupPath, "File")

# Set the databse file location
$dbRestoreFile = new-object("Microsoft.SqlServer.Management.Smo.RelocateFile")
$dbRestoreLog = new-object("Microsoft.SqlServer.Management.Smo.RelocateFile")
$dbRestoreFile.LogicalFileName = $dbname
$dbRestoreFile.PhysicalFileName = $sqlServer.Information.MasterDBPath + "\" + $dbRestore.Database + "_Data.mdf"
$dbRestoreLog.LogicalFileName = $dbname + "_Log"
$dbRestoreLog.PhysicalFileName = $sqlServer.Information.MasterDBLogPath + "\" + $dbRestore.Database + "_Log.ldf"
$dbRestore.RelocateFiles.Add($dbRestoreFile)
$dbRestore.RelocateFiles.Add($dbRestoreLog)

# Call the SqlRestore method to complete restore database 
$dbRestore.SqlRestore($sqlServer)

Write-Host "...SQL Database"$dbname" Restored Successfullyy..."

