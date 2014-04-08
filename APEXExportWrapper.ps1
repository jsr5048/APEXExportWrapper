echo "Starting APEXExportWrapper"
$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition

. "$scriptPath\Select-Item.ps1"

$hostsData = Get-Content $scriptPath\"APEXExportWrapperHosts.conf" | ConvertFrom-Csv -Delimiter "," -Header "sid","connect_string"
$hosts = $hostsData | Select -Property "sid"
$appHeaders = "name","app_id","owner"

$appHeaders = $appHeaders + $hosts
echo "New Set Follows"
echo $appHeaders
$apps = Get-Content $scriptPath\"APEXExportWrapperApps.conf" | ConvertFrom-Csv -Delimiter "," -Header $appHeaders

$sidList = $hostsData | Select -Property "sid" -ExpandProperty "sid"
$sidNum = Select-Item -Caption "APEXExportWrapper" -Message "Choose the SID to use" -choice $sidList
$sid = $sidList[$sidNum]

$hostRecord = $file | Select-String -Pattern "^$sid" |ConvertFrom-Csv -Delimiter "," -Header "sid","connect_string"
echo $hostRecord

$hostDesc = $hostRecord.connect_string
echo "host:$($hostRecord.connect_string)"

$cred = Get-Credential -credential "HRCTL@$sid" 
$plainText = $cred.GetNetworkCredential().Password

