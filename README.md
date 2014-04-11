# APEXExportWrapper
The purpose of this project is to simplify the on-demand exporting 
and splitting of Oracle Application Express (APEX) code to facillitate
granular version control.

## Oracle/Java Dependencies
The actual exporting and splitting of the application is handled by
Java classes provided by Oracle, as part of the APEX distribution,
with database connectivity via JDBC.

Since I don't believe I can legally re-distributte Oracle's files, you
must obtain those JARs yourself.

Download the APEX distribution from [OTN's APEX Download Page] (http://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html?ssSourceSiteId=otnru)

Once you've downloaded the .zip file, copy $zipbase/apex/utilities/oracle/apex/\*.class 
to the ./APEX_Export_JARs/oracle/apex/ directory.

You'll also need to download the [Oracle Instant Client](http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html),
then locate ojdbc6.jar (likely in $zipbase/instant_client_\*/ojdbc6.jar) and copy it to ./APEX_Export_JARs

*Note*
If you understand Java and classpaths, you can place these files wherever you'd like.  For example, if you
have the instant client already installed and on your CLASSPATH, you don't have to copy objdbc6.jar into
your install folder.

## Configuration Files
The configuration files use the CSV format which is easy to parse in both PowerShell and bash.

### APEXExportWrapperHosts.conf

sid 	| connect_string
:------ | ------------:
prod	| prodsystem.example.com:1521:prod
dev		| devsystem.example.com:1521:dev
test	| testsystem.example.com:1521:test
findev	| finance_dev.example.com:1521:findev
finprod	| finance.example.com:1521:finprod

### APEXExportWrapperApps.conf

NAME	| APP_ID	| OWNER	| dev	| test	| prod	| findev	| finprod	|
:-------|:----------|:-----:|:-----:|:-----:|:-----:|:---------:|:---------:|
HR|100|HR_USER|Y|Y|Y|N|N
FIN|200|FIN_USER|N|N|N|Y|Y

## Configuring PowerShell - Running on Windows
PowerShell is included in Windows 7 and 8.  Windows 8 comes with PowerShell 3.0, but these
scripts target 2.0 to minimize requirements.

The default security policy on Windows prevents execution of PowerShell scripts.  You can enable
execution with the [Set-ExecutionPolicy Cmdlet](http://technet.microsoft.com/en-us/library/ee176961.aspx), 
start PowerShell (Start -> Run -> PowerShell) and run
```powershell
	Set-ExecutionPolicy RemoteSigned
```
By default Windows won't run PowerShell (\*.ps1) scripts, the default security policy restricts

## Running on *nix/OSX

