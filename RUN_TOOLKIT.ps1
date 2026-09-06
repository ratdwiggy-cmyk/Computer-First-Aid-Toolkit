# COMPUTER TOOLKIT — SAFE WINDOWS LAUNCHER
# Safe diagnostics and session management.
# Does not automatically perform destructive operations.

$Base = "D:\STORAGE_HUB\COMPUTER_TOOLKIT"

function Test-RequiredFile {
    param([string]$File)

    if (-not (Test-Path $File -PathType Leaf)) {
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Red
        Write-Host "TOOLKIT INTEGRITY ERROR" -ForegroundColor Red
        Write-Host "============================================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Required toolkit file is missing:" -ForegroundColor Yellow
        Write-Host $File
        Write-Host ""
        Write-Host "The toolkit has stopped before starting an operation."
        Write-Host "Use Toolkit Self-Check or inspect the USB contents."
        Write-Host ""
        Read-Host "Press ENTER to exit"
        exit 1
    }
}

$RequiredFiles = @(
    "$Base\01_SYSTEM_INFO\Get-SystemInfo.ps1"
    "$Base\02_HARDWARE_DIAGNOSTICS\Get-StorageHealth.ps1"
    "$Base\02_HARDWARE_DIAGNOSTICS\Get-MemoryDiagnostics.ps1"
    "$Base\02_HARDWARE_DIAGNOSTICS\Get-GpuDiagnostics.ps1"
    "$Base\02_HARDWARE_DIAGNOSTICS\Get-NetworkDiagnostics.ps1"
    "$Base\02_HARDWARE_DIAGNOSTICS\Get-BatteryDiagnostics.ps1"
    "$Base\02_HARDWARE_DIAGNOSTICS\Get-DeviceErrors.ps1"
    "$Base\03_NETWORK\Network-Triage.ps1"
    "$Base\05_WINDOWS_REPAIR\Windows-Repair-Assessment.ps1"
    "$Base\06_BACKUP\Safe-FileBackup.ps1"
    "$Base\07_SECURITY_CHECKS\Security-Assessment.ps1"
    "$Base\08_PORTABLE_TOOLS\Run-Sysinternals.ps1"
    "$Base\09_DOCUMENTATION\SAFETY_RULES.txt"
    "$Base\START_HERE.txt"
    "$Base\10_SCRIPTS\Start-NewSession.ps1"
    "$Base\10_SCRIPTS\Collect-SessionReports.ps1"
    "$Base\10_SCRIPTS\Test-Toolkit.ps1"
)

foreach ($File in $RequiredFiles) {
    Test-RequiredFile $File
}

Clear-Host

Write-Host "============================================================"
Write-Host "          COMPUTER TOOLKIT — PRE-FLIGHT CHECK"
Write-Host "============================================================"
Write-Host ""
Write-Host "[ ] I have permission to inspect this computer."
Write-Host "[ ] I understand the reported problem."
Write-Host "[ ] I know which computer I am working on."
Write-Host "[ ] I have considered important data preservation."
Write-Host "[ ] I will not bypass passwords or security controls."
Write-Host "[ ] I will not perform destructive operations casually."
Write-Host ""
Write-Host "OBSERVE -> PRESERVE -> DIAGNOSE -> CONFIRM -> REPAIR"
Write-Host ""

$Ready = Read-Host "Type READY to continue, or anything else to exit"

if ($Ready -ne "READY") {
    Write-Host ""
    Write-Host "Toolkit stopped. No diagnostic operation was started."
    exit
}

while ($true) {
    Clear-Host

    Write-Host "============================================================"
    Write-Host "          COMPUTER TOOLKIT — SAFE WINDOWS MODE"
    Write-Host "============================================================"
    Write-Host ""
    Write-Host "OBSERVE -> PRESERVE -> DIAGNOSE -> CONFIRM -> REPAIR"
    Write-Host ""
    Write-Host "1.  System Information"
    Write-Host "2.  Storage Health"
    Write-Host "3.  Memory Diagnostics"
    Write-Host "4.  GPU Diagnostics"
    Write-Host "5.  Network Diagnostics"
    Write-Host "6.  Battery Diagnostics"
    Write-Host "7.  Device Errors"
    Write-Host "8.  Network Triage"
    Write-Host "9.  Windows Repair Assessment"
    Write-Host "10. Security Assessment"
    Write-Host "11. Open Safety Rules"
    Write-Host "12. Open Start Here Guide"
    Write-Host "13. Sysinternals Diagnostic Tools"
    Write-Host "14. Start New Session"
    Write-Host "15. Collect Session Reports"
    Write-Host "16. Toolkit Self-Check"
    Write-Host "Q.  Quit"
    Write-Host ""

    $Choice = Read-Host "Select an option"

    switch ($Choice.ToUpper()) {

        "1" {
            & "$Base\01_SYSTEM_INFO\Get-SystemInfo.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "2" {
            & "$Base\02_HARDWARE_DIAGNOSTICS\Get-StorageHealth.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "3" {
            & "$Base\02_HARDWARE_DIAGNOSTICS\Get-MemoryDiagnostics.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "4" {
            & "$Base\02_HARDWARE_DIAGNOSTICS\Get-GpuDiagnostics.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "5" {
            & "$Base\02_HARDWARE_DIAGNOSTICS\Get-NetworkDiagnostics.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "6" {
            & "$Base\02_HARDWARE_DIAGNOSTICS\Get-BatteryDiagnostics.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "7" {
            & "$Base\02_HARDWARE_DIAGNOSTICS\Get-DeviceErrors.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "8" {
            & "$Base\03_NETWORK\Network-Triage.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "9" {
            & "$Base\05_WINDOWS_REPAIR\Windows-Repair-Assessment.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "10" {
            & "$Base\07_SECURITY_CHECKS\Security-Assessment.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "11" {
            notepad "$Base\09_DOCUMENTATION\SAFETY_RULES.txt"
        }

        "12" {
            notepad "$Base\START_HERE.txt"
        }

        "13" {
            & "$Base\08_PORTABLE_TOOLS\Run-Sysinternals.ps1"
        }

        "14" {
            & "$Base\10_SCRIPTS\Start-NewSession.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "15" {
            & "$Base\10_SCRIPTS\Collect-SessionReports.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "16" {
            & "$Base\10_SCRIPTS\Test-Toolkit.ps1"
            Read-Host "`nPress ENTER to return to the menu"
        }

        "Q" {
            break
        }

        default {
            Write-Host ""
            Write-Host "Invalid selection." -ForegroundColor Yellow
            Start-Sleep -Seconds 1
        }
    }
}
