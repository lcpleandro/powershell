<#
  Script to back up all Power BI reports from a specific workspace.
  Adds today's date to the folder name to help with daily versioning.

  Requirements:
  - Module: MicrosoftPowerBIMgmt
#>

# Install module if it's not already installed
if (-not (Get-Module -ListAvailable -Name MicrosoftPowerBIMgmt)) {
    Write-Host "MicrosoftPowerBIMgmt module not found. Installing..."
    Install-Module -Name MicrosoftPowerBIMgmt -Force
}

# Login
try {
    Login-PowerBI -ErrorAction Stop
} catch {
    Write-Error "Login failed. Please check your credentials."
    exit 1
}

# Workspace name
$workspaceName = "Prueba - Name"

# Get the workspace
$workspace = Get-PowerBIWorkspace -Name $workspaceName
if (-not $workspace) {
    Write-Error "Workspace '$workspaceName' not found."
    exit 1
}

# Create output folder with today's date
$today = Get-Date -Format "yyyy_MM_dd"
$outputDir = "C:\PowerBIReportsBackup\$today\"

if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Get all reports from the workspace
$reports = Get-PowerBIReport -WorkspaceId $workspace.Id

if (-not $reports) {
    Write-Warning "No reports found in workspace '$workspaceName'."
    exit 0
}

# Export each report
foreach ($report in $reports) {
    $fileName = "$($report.Name).pbix"
    $filePath = Join-Path $outputDir $fileName

    Write-Host "Exporting: $fileName"

    if (Test-Path $filePath) {
        Remove-Item $filePath -Force
    }

    try {
        Export-PowerBIReport -WorkspaceId $workspace.Id -Id $report.Id -OutFile $filePath -ErrorAction Stop
    } catch {
        Write-Warning "Failed to export '$fileName': $_"
    }
}

Write-Host "Backup completed: $outputDir"
