<#
 This script downloads all Power BI Reports in a workspace.
 It adds today's date to the beginning of the file name to make it 
 easier to take daily backups.
 2020-10-12
 ABI Cube corp.
>#


<#
  This script requires the MicrosoftPowerBIMgmt module.
  Run the following command to install it if not already installed: 
  Install-Module -Name MicrosoftPowerBIMgmt 
#>

<#If the login step to PBI fails, try running the following line first.
 [Net.ServicePointManager]:SecurityProtocol = [Net.SecurityProtocolType]::Tsl12
#>

#Log in to Power BI Service
Login-PowerBI 

$PBIWorkspace = Get-PowerBIWorkspace -Name "Prueba - Power BI Acindar"

$PBIReports = Get-PowerBIReport -WorkspaceId $PBIWorkspace.Id # -Name "My Report Name" #Use the Name parameter to limit to one report.

$TodaysDate = Get-Date -Format "MM_dd_yyyy_"

$OutPutPath = "C:\PowerBIReportsBackup\" + $TodaysDate 

#Loop through the reports:
ForEach($Report in $PBIReports)
{
 Write-Host "Downloading " $Report.name 
 $OutputFile = $OutPutPath +  $Report.name + ".pbix"

 # If the file exists, delete it first; otherwise, the Export-PowerBIReport will fail.
 if (Test-Path $OutputFile)
 {
     Remove-Item $OutputFile
 }

 Export-PowerBIReport -WorkspaceId $PBIWorkspace.ID -Id $Report.ID -OutFile $OutputFile

}