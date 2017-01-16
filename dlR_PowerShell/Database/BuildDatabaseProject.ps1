#
# BuildDatabaseProject.ps1
#

$baseDir = "C:\Users\pdelosreyes\Documents\Dev\SGNL_Master_Oct_2_2015\SQL\SQLSignalInformatics\"
$outputFolder = $baseDir + "..\Testing"
$msbuild = """C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"""
$options = "/p:Configuration=Release"
$releaseFolder = $baseDir + "SGNL_WAREHOUSE\bin\Release"

# if the output folder exists, delete it
if ([System.IO.Directory]::Exists($outputFolder))
{
 [System.IO.Directory]::Delete($outputFolder, 1)
}

# make sure our working directory is correct
cd $baseDir

# create the build command and invoke it 
# note that if you want to debug, remove the "/noconsolelogger" 
# from the $options string
$clean = $msbuild + " ""SQLSignalInformatics.sln"" " + $options + " /target:Clean"
$build = $msbuild + " ""SQLSignalInformatics.sln"" " + $options + " /target:Build"
Invoke-Expression $clean
Invoke-Expression $build

# move all the files that were built to the output folder
[System.IO.Directory]::Move($releaseFolder, $outputFolder)