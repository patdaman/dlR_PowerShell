#
# DeployDacpac.ps1
#

#param(
#    [string]$sqlserver = $( throw "Missing: parameter sqlserver"),
#    [string]$dacpac = $( throw "Missing: parameter dacpac"),
#    [string]$dbname = $( throw "Missing: parameter dbname"),
#	[string]$profile = $( throw "Missing: parameter profile")
#)

[string]$sqlserver = "SG-CA01-DVM-002"
#[string]$dacpac = "..\..\SQL\SQLSignalInformatics\SGNL_WAREHOUSE\bin\Output\SGNL_WAREHOUSE.dacpac"
[string]$dacpac = "C:\Temp\SGNL_WAREHOUSE.dacpac"
[string]$profile = 

# Extract DACPAC from database
# Extract pubs database to a file using DAC application name pubs, version 1.2.3.4
#$d.extract("c:\temp\SGNL_WAREHOUSE.dacpac", "SGNL_WAREHOUSE", "SGNL_WAREHOUSE", "1.2.3.4") 

Write-Host "Deploying the DB with the following settings"
Write-Host "sqlserver:   $sqlserver"
Write-Host "dacpac: $dacpac"


#Register the DLL we need
Add-Type -Path "${env:ProgramFiles(x86)}\Microsoft SQL Server\110\DAC\bin\Microsoft.SqlServer.Dac.dll" 
#Read a publish profile XML to get the deployment options
$dacProfile = [Microsoft.SqlServer.Dac.DacProfile]::Load("..\..\SQL\SQLSignalInformatics\SGNL_WAREHOUSE\SGNL_WAREHOUSE.BETA.publish.xml")
#Use the connect string from the profile to initiate the service
$dacService = New-Object Microsoft.SqlServer.dac.dacservices ($dacProfile.TargetConnectionString)
#Load the dacpac
$dacPackage = [Microsoft.SqlServer.Dac.DacPackage]::Load("$dacpac")

$dacService.deploy($dacPackage, $dacProfile.TargetDatabaseName, $true, $dacProfile.DeployOptions)
#$dacService.GenerateDeployScript($dacPackage, $dacProfile.TargetDatabaseName, $dacProfile.DeployOptions
