# COMPUTER TOOLKIT — DEVICE ERROR DIAGNOSTICS
# Read-only Windows device inspection.
# Does not install, update, remove, or disable drivers.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\02_HARDWARE_DIAGNOSTICS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("DEVICE_ERRORS_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — DEVICE ERROR DIAGNOSTICS" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no driver changes performed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- DEVICES WITH WINDOWS ERROR CODES ---" | Out-File $Report -Append

$Errors = Get-CimInstance Win32_PnPEntity |
    Where-Object {
        $null -ne $_.ConfigManagerErrorCode -and
        $_.ConfigManagerErrorCode -ne 0
    } |
    Select-Object Name, Manufacturer, DeviceID,
        ConfigManagerErrorCode, Status, StatusInfo

if ($Errors) {
    $Errors |
        Format-List |
        Out-File $Report -Append
}
else {
    "No Windows Plug and Play device errors reported." |
        Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- ALL DEVICE STATUS ---" | Out-File $Report -Append

Get-CimInstance Win32_PnPEntity |
    Select-Object Name, Manufacturer, Status, ConfigManagerErrorCode |
    Sort-Object Status, Name |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"An error code identifies a Windows-reported device problem." | Out-File $Report -Append
"An error code does not automatically mean the hardware itself is defective." | Out-File $Report -Append
"Possible causes include drivers, configuration, firmware, hardware, or connectivity." | Out-File $Report -Append
"Do not automatically install drivers based solely on this report." | Out-File $Report -Append
"Identify the device and investigate the specific error before making changes." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Device error report created:"
Write-Host $Report
Write-Host ""
