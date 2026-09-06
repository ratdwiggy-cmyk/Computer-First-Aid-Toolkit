# COMPUTER TOOLKIT — WINDOWS REPAIR ASSESSMENT
# Assessment only.
# Does NOT repair Windows.
#
# IMPORTANT:
# DISM /CheckHealth and SFC /verifyonly are diagnostic operations.
# No repair operation is intentionally performed by this script.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\05_WINDOWS_REPAIR"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("WINDOWS_REPAIR_ASSESSMENT_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — WINDOWS REPAIR ASSESSMENT" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"ASSESSMENT ONLY — no repair commands were intentionally performed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- WINDOWS VERSION ---" | Out-File $Report -Append

Get-CimInstance Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber, OSArchitecture |
    Format-List |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- DISM COMPONENT STORE CHECK ---" | Out-File $Report -Append
"Command: DISM /Online /Cleanup-Image /CheckHealth" | Out-File $Report -Append
"" | Out-File $Report -Append

DISM.exe /Online /Cleanup-Image /CheckHealth 2>&1 |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- SYSTEM FILE CHECK ---" | Out-File $Report -Append
"Command: sfc /verifyonly" | Out-File $Report -Append
"" | Out-File $Report -Append

sfc.exe /verifyonly 2>&1 |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- INTERPRETATION ---" | Out-File $Report -Append
"DISM /CheckHealth checks whether Windows has recorded component-store corruption." | Out-File $Report -Append
"SFC /verifyonly checks protected Windows system files without attempting repair." | Out-File $Report -Append
"A reported problem does not mean repair should immediately be performed." | Out-File $Report -Append
"Preserve important data before substantial repair work." | Out-File $Report -Append
"Do not run DISM /RestoreHealth or sfc /scannow from this assessment script." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Windows repair assessment created:"
Write-Host $Report
Write-Host ""
