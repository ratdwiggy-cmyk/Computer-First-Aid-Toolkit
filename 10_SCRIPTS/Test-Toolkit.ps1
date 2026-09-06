# COMPUTER TOOLKIT — SELF CHECK
# Verifies that the toolkit's expected folders and core files exist.
# Does not inspect or modify the computer being diagnosed.

$Base = "D:\STORAGE_HUB\COMPUTER_TOOLKIT"

Clear-Host

Write-Host "============================================================"
Write-Host "          COMPUTER TOOLKIT — SELF CHECK"
Write-Host "============================================================"
Write-Host ""

if (-not (Test-Path $Base)) {
    Write-Host "ERROR: Toolkit folder not found." -ForegroundColor Red
    exit
}

$Folders = @(
    "01_SYSTEM_INFO",
    "02_HARDWARE_DIAGNOSTICS",
    "03_NETWORK",
    "04_FILE_RECOVERY",
    "05_WINDOWS_REPAIR",
    "06_BACKUP",
    "07_SECURITY_CHECKS",
    "08_PORTABLE_TOOLS",
    "09_DOCUMENTATION",
    "10_SCRIPTS",
    "SESSIONS"
)

$Files = @(
    "RUN_TOOLKIT.ps1",
    "01_SYSTEM_INFO\Get-SystemInfo.ps1",
    "02_HARDWARE_DIAGNOSTICS\Get-StorageHealth.ps1",
    "02_HARDWARE_DIAGNOSTICS\Get-MemoryDiagnostics.ps1",
    "02_HARDWARE_DIAGNOSTICS\Get-GpuDiagnostics.ps1",
    "02_HARDWARE_DIAGNOSTICS\Get-NetworkDiagnostics.ps1",
    "02_HARDWARE_DIAGNOSTICS\Get-BatteryDiagnostics.ps1",
    "02_HARDWARE_DIAGNOSTICS\Get-DeviceErrors.ps1",
    "03_NETWORK\Network-Triage.ps1",
    "05_WINDOWS_REPAIR\Windows-Repair-Assessment.ps1",
    "06_BACKUP\Safe-FileBackup.ps1",
    "07_SECURITY_CHECKS\Security-Assessment.ps1",
    "08_PORTABLE_TOOLS\Run-Sysinternals.ps1",
    "09_DOCUMENTATION\SAFETY_RULES.txt",
    "START_HERE.txt",
    "09_DOCUMENTATION\QUICK_TRIAGE.txt",
    "09_DOCUMENTATION\INCIDENT_WORKSHEET_TEMPLATE.txt",
    "09_DOCUMENTATION\HARDWARE_DIAGNOSTICS_WORKFLOW.txt",
    "09_DOCUMENTATION\FILE_RECOVERY_GUIDE.txt",
    "09_DOCUMENTATION\BACKUP_PRESERVATION_GUIDE.txt",
    "09_DOCUMENTATION\WINDOWS_REPAIR_DECISION_GUIDE.txt",
    "09_DOCUMENTATION\PORTABLE_TOOLS_INVENTORY.txt",
    "09_DOCUMENTATION\ADVANCED_TOOLS_GUIDE.txt",
    "09_DOCUMENTATION\MASTER_INDEX.txt"
    "09_DOCUMENTATION\OPERATOR_CHECKLIST.txt",
    "09_DOCUMENTATION\SESSION_MANAGEMENT_GUIDE.txt",
    "10_SCRIPTS\Start-NewSession.ps1",
    "10_SCRIPTS\Collect-SessionReports.ps1"
)

$FolderFailures = 0
$FileFailures = 0

Write-Host "--- FOLDERS ---"
Write-Host ""

foreach ($Folder in $Folders) {
    $Path = Join-Path $Base $Folder

    if (Test-Path $Path -PathType Container) {
        Write-Host "[OK]   $Folder"
    }
    else {
        Write-Host "[MISS] $Folder" -ForegroundColor Yellow
        $FolderFailures++
    }
}

Write-Host ""
Write-Host "--- CORE FILES ---"
Write-Host ""

foreach ($File in $Files) {
    $Path = Join-Path $Base $File

    if (Test-Path $Path -PathType Leaf) {
        Write-Host "[OK]   $File"
    }
    else {
        Write-Host "[MISS] $File" -ForegroundColor Yellow
        $FileFailures++
    }
}

Write-Host ""
Write-Host "============================================================"
Write-Host "SUMMARY"
Write-Host "============================================================"
Write-Host ""

Write-Host "Missing folders: $FolderFailures"
Write-Host "Missing files:   $FileFailures"
Write-Host ""

if (($FolderFailures -eq 0) -and ($FileFailures -eq 0)) {
    Write-Host "TOOLKIT STRUCTURE: OK" -ForegroundColor Green
}
else {
    Write-Host "TOOLKIT STRUCTURE: INCOMPLETE" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "No repair or diagnostic operation was performed."
Write-Host "============================================================"

