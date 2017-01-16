$server = "SG-CA01-DVM-004"
$process = [WMICLASS]"\\$server\ROOT\CIMV2:win32_process"  
$result = $process.Create("C:\users\pdelosreyes\Documents\Dev\SGNL_Master_Oct_2_2015\Apps\DeployPackager\DeployPackager.app.deploy.cmd") 