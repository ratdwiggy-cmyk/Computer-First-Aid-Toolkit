# COMPUTER TOOLKIT — SYSINTERNALS DIAGNOSTIC LAUNCHER
# Approved observation/diagnostic tools only.
# Does not launch restricted Sysinternals utilities.

$Tools = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\08_PORTABLE_TOOLS\SYSINTERNALS"

while ($true) {
    Clear-Host

    Write-Host "============================================================"
    Write-Host "       COMPUTER TOOLKIT — SYSINTERNALS DIAGNOSTICS"
    Write-Host "============================================================"
    Write-Host ""
    Write-Host "These tools are primarily for observation."
    Write-Host "They do not automatically repair Windows."
    Write-Host ""
    Write-Host "1. Process Explorer"
    Write-Host "2. Autoruns"
    Write-Host "3. Process Monitor"
    Write-Host "4. TCPView"
    Write-Host "5. RAMMap"
    Write-Host "6. Sigcheck"
    Write-Host "Q. Quit"
    Write-Host ""

    $Choice = Read-Host "Select a tool"

    switch ($Choice.ToUpper()) {

        "1" {
            Write-Host ""
            Write-Host "Process Explorer will inspect running processes."
            $Confirm = Read-Host "Type YES to launch"
            if ($Confirm -eq "YES") {
                Start-Process "$Tools\procexp64.exe"
            }
            Read-Host "Press ENTER to return"
        }

        "2" {
            Write-Host ""
            Write-Host "Autoruns will inspect programs configured to start automatically."
            $Confirm = Read-Host "Type YES to launch"
            if ($Confirm -eq "YES") {
                Start-Process "$Tools\Autoruns64.exe"
            }
            Read-Host "Press ENTER to return"
        }

        "3" {
            Write-Host ""
            Write-Host "Process Monitor performs detailed activity monitoring."
            Write-Host "It can generate a large amount of information."
            $Confirm = Read-Host "Type YES to launch"
            if ($Confirm -eq "YES") {
                Start-Process "$Tools\Procmon64.exe"
            }
            Read-Host "Press ENTER to return"
        }

        "4" {
            Write-Host ""
            Write-Host "TCPView displays active network connections."
            $Confirm = Read-Host "Type YES to launch"
            if ($Confirm -eq "YES") {
                Start-Process "$Tools\tcpview64.exe"
            }
            Read-Host "Press ENTER to return"
        }

        "5" {
            Write-Host ""
            Write-Host "RAMMap displays detailed physical-memory usage."
            $Confirm = Read-Host "Type YES to launch"
            if ($Confirm -eq "YES") {
                Start-Process "$Tools\RAMMap64.exe"
            }
            Read-Host "Press ENTER to return"
        }

        "6" {
            Write-Host ""
            Write-Host "Sigcheck inspects executable signatures and file information."
            $Confirm = Read-Host "Type YES to launch"
            if ($Confirm -eq "YES") {
                Start-Process "$Tools\sigcheck64.exe"
            }
            Read-Host "Press ENTER to return"
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
