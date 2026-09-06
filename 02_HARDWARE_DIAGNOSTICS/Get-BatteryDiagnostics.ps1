# COMPUTER TOOLKIT — BATTERY DIAGNOSTICS
# Read-only battery information.
# Does not change charging, power, or battery settings.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\02_HARDWARE_DIAGNOSTICS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("BATTERY_DIAGNOSTICS_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — BATTERY DIAGNOSTICS" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no power settings changed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- BATTERY INFORMATION ---" | Out-File $Report -Append

$Batteries = Get-CimInstance Win32_Battery

if ($Batteries) {
    foreach ($Battery in $Batteries) {
        "----------------------------------------" | Out-File $Report -Append
        "Name                 : $($Battery.Name)" | Out-File $Report -Append
        "Device ID            : $($Battery.DeviceID)" | Out-File $Report -Append
        "Status               : $($Battery.Status)" | Out-File $Report -Append
        "Battery Status Code  : $($Battery.BatteryStatus)" | Out-File $Report -Append
        "Estimated Charge     : $($Battery.EstimatedChargeRemaining) %" | Out-File $Report -Append
        "Estimated Runtime    : $($Battery.EstimatedRunTime) minutes" | Out-File $Report -Append
        "Chemistry            : $($Battery.Chemistry)" | Out-File $Report -Append
        "Design Voltage       : $($Battery.DesignVoltage) mV" | Out-File $Report -Append
    }
}
else {
    "No battery reported by Windows." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- BATTERY CAPACITY / HEALTH DATA ---" | Out-File $Report -Append

$BatteryStatic = Get-CimInstance -Namespace "root\wmi" -ClassName BatteryStaticData

if ($BatteryStatic) {
    $BatteryStatic |
        Select-Object InstanceName, DesignedCapacity, FullChargedCapacity,
            CycleCount, Chemistry |
        Format-List |
        Out-File $Report -Append
}
else {
    "Extended battery capacity information: Not Reported" | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- BATTERY STATUS DATA ---" | Out-File $Report -Append

$BatteryStatus = Get-CimInstance -Namespace "root\wmi" -ClassName BatteryStatus

if ($BatteryStatus) {
    $BatteryStatus |
        Select-Object InstanceName, PowerOnline, Charging,
            Discharging, RemainingCapacity, Voltage |
        Format-List |
        Out-File $Report -Append
}
else {
    "Extended battery status information: Not Reported" | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"Battery information varies by computer manufacturer and firmware." | Out-File $Report -Append
"Not Reported means Windows did not expose that particular value." | Out-File $Report -Append
"Estimated runtime is not a reliable measure of battery health." | Out-File $Report -Append
"Battery capacity should be compared with the battery's design capacity when both are available." | Out-File $Report -Append
"Do not change power or charging settings during basic diagnosis." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Battery diagnostic report created:"
Write-Host $Report
Write-Host ""
