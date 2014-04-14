﻿Function Verify-Environment-For-Export 
{
	$goodToGo = 1
	$depends = "APEX_Export_JARs/ojdbc6.jar","APEX_Export_JARs/oracle/apex/APEXExport.class", "APEX_Export_JARs/oracle/apex/APEXExportSplitter.class"
	Write-Host "Running in:$scriptPath"
	try {
		$javaExists = Get-Command "java" -ErrorAction Stop
	} catch {
		Write-Host "Can't find Java, make sure it's installed and on your %PATH%"
		$goodToGo = 0
	}
	
	foreach ( $depend in $depends ) {
		if ( !(Test-Path "$scriptPath/$depend") ) {
			$goodToGo = 0
			Write-Host "Cannot find dependency:"
			Write-Host "	$scriptPath/$depend" -ForegroundColor Red
		}
	}
	return $goodToGo
}

Function Execute-APEX-Export

{
	Param(
		[String]$my_connect_string,
		[String]$my_password,
		[Object]$myApp
	)
	
	$myClassPath = "$scriptPath\APEX_Export_JARs;$scriptPath\APEX_Export_JARs\ojdbc6.jar"
	$ipv4 = "-Djava.net.preferIPv4Stack=true" # Was having issues with Java defaulting to IPv6
	$progName = "oracle.apex.APEXExport"
	echo $myApp."owner"
	
	$javaLoc = Get-Command java
	#echo $javaLoc.Definition -cp ($myClassPath) ($ipv4) ($progName) -db ($my_connect_string) -password ($my_password) -applicationid ($myApp.app_id) -skipExportDate -expSavedReports
	$javaJobOutput = & $javaLoc.Definition -cp ($myClassPath) ($ipv4) ($progName) -db ($my_connect_string) -user ($myApp.owner) -password ($my_password) -applicationid ($myApp.app_id) -skipExportDate -expSavedReports
	echo $javaJobOutput
}