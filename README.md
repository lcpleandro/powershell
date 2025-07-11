# Power BI Reports Backup

This PowerShell project allows you to **automatically export and back up all reports** from a specific Power BI workspace. It adds the current date to the output folder to help with versioning and traceability.

---

## 📦 Features

- Exports all `.pbix` files from a given workspace
- Organizes backups by date (`YYYY_MM_DD`)
- Automatically installs required modules (`MicrosoftPowerBIMgmt`)
- Handles missing folders and file overwrites
- Includes optional logging and task scheduling setup

---

## ⚙️ Prerequisites

- Windows PowerShell 5.1+
- Power BI Admin or sufficient permissions to export reports
- Power BI module installed:
  ```powershell
  Install-Module -Name MicrosoftPowerBIMgmt
  ```

---
---

## 🚀 How to Use

1. Clone or download this repository.

2. Update `config.json` with:
   ```json
   {
     "workspace_name": "Your Workspace Name",
     "output_dir": "C:\PowerBIReportsBackup",
     "log_dir": "C:\PowerBIReportsBackup\logs"
   }
   ```

3. Run the main script:
 
## ❓ Troubleshooting

- **Login issues?** Make sure you're logged into Power BI with the correct permissions.
- **Module not found?** Manually run `Install-Module -Name MicrosoftPowerBIMgmt -Force`.
