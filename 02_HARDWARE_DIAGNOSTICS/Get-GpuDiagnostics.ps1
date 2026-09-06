# COMPUTER TOOLKIT — DISPLAY / GPU DIAGNOSTICS
# Read-only graphics hardware and driver information.
# Does not install, update, or remove drivers.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\02_HARDWARE_DIAGNOSTICS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("GPU_DIAGNOSTICS_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — DISPLAY / GPU DIAGNOSTICS" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no driver changes performed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- GRAPHICS ADAPTERS ---" | Out-File $Report -Append

Get-CimInstance Win32_VideoController |
    Select-Object Name, AdapterCompatibility,
        @{Name="AdapterRAM_GB";Expression={
            if ($_.AdapterRAM) {[math]::Round($_.AdapterRAM / 1GB, 2)}
            else {"Not Reported"}
        }},
        DriverVersion, DriverDate, VideoModeDescription,
        Status, Availability |
    Format-List |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- DISPLAY MONITORS ---" | Out-File $Report -Append

Get-CimInstance Win32_DesktopMonitor |
    Select-Object Name, MonitorType, ScreenWidth, ScreenHeight, Status |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- DISPLAY-RELATED DEVICE ERRORS ---" | Out-File $Report -Append

$Errors = Get-CimInstance Win32_PnPEntity |
    Where-Object {
        $_.ConfigManagerErrorCode -ne 0 -and
        (
            $_.Name -match "display|video|graphics|AMD|Radeon|GPU"
        )
    } |
    Select-Object Name, DeviceID, ConfigManagerErrorCode, Status

if ($Errors) {
    $Errors | Format-List | Out-File $Report -Append
}
else {
    "No display-related device errors reported." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"Driver version identifies the installed driver; it does not automatically mean an update is required." | Out-File $Report -Append
"Status is Windows-reported device information." | Out-File $Report -Append
"Do not replace graphics drivers during basic diagnosis unless the problem and correct driver are confirmed." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "GPU diagnostic report created:"
Write-Host $Report
Write-Host ""
