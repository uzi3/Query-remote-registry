#Requires Powershell 5.0

$ErrorActionPreference = "Stop"

Class VersionCheck
{
$MacNam
$Value
}

$Machines = Get-Content C:\Temp\MachineList.txt

foreach ($machinename in $Machines)
{
$Object=New-Object VersionCheck
$Object.MacNam = $machinename
$key = "SYSTEM\\CurrentControlSet\\Services\\NTDS\Parameters"
$valuename = "Strict Replication Consistency"

Try
{
$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $machinename)
}

Catch
{
$Object.Value = "Error"
$Object | export-csv C:\Temp\SRC.csv -Append -NoTypeInformation
continue
}

$regkey = $reg.opensubkey($key)
$object.Value = $regkey.getvalue($valuename)
$Object | export-csv C:\Temp\SRC.csv -Append -NoTypeInformation
Clear-Variable Object
}
