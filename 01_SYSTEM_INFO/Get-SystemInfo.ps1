# COMPUTER TOOLKIT — WINDOWS SYSTEM INFORMATION
# Read-only diagnostic report
# Does not intentionally modify system configuration.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\01_SYSTEM_INFO"
$Report = Join-Path $Root ("SYSTEM_INFO_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

New-Item -Path $Root -ItemType Directory -Force | Out-Null

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — WINDOWS SYSTEM INFO" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"" | Out-File $Report -Append

"--- WINDOWS ---" | Out-File $Report -Append
Get-CimInstance Win32_OperatingSystem |
    Select-Object Caption, Version, BuildNumber, OSArchitecture, LastBootUpTime |
    Format-List | Out-File $Report -Append

"--- COMPUTER ---" | Out-File $Report -Append
Get-CimInstance Win32_ComputerSystem |
    Select-Object Manufacturer, Model, SystemType, TotalPhysicalMemory |
    Format-List | Out-File $Report -Append

"--- BIOS / UEFI ---" | Out-File $Report -Append
Get-CimInstance Win32_BIOS |
    Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate |
    Format-List | Out-File $Report -Append

"--- CPU ---" | Out-File $Report -Append
Get-CimInstance Win32_Processor |
    Select-Object Name, Manufacturer, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed |
    Format-List | Out-File $Report -Append

"--- MEMORY ---" | Out-File $Report -Append
Get-CimInstance Win32_PhysicalMemory |
    Select-Object Manufacturer, PartNumber, Capacity, Speed, DeviceLocator |
    Format-Table -AutoSize | Out-File $Report -Append

"--- PHYSICAL DISKS ---" | Out-File $Report -Append
Get-CimInstance Win32_DiskDrive |
    Select-Object Index, Model, SerialNumber, InterfaceType, MediaType, Size |
    Format-Table -AutoSize | Out-File $Report -Append

"--- VOLUMES ---" | Out-File $Report -Append
Get-Volume |
    Select-Object DriveLetter, FileSystemLabel, FileSystem, HealthStatus, Size, SizeRemaining |
    Format-Table -AutoSize | Out-File $Report -Append

"--- GPU ---" | Out-File $Report -Append
Get-CimInstance Win32_VideoController |
    Select-Object Name, DriverVersion, VideoModeDescription, AdapterRAM |
    Format-List | Out-File $Report -Append

"--- NETWORK ADAPTERS ---" | Out-File $Report -Append
Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed, MacAddress |
    Format-Table -AutoSize | Out-File $Report -Append

"--- BATTERY ---" | Out-File $Report -Append
Get-CimInstance Win32_Battery |
    Select-Object Name, BatteryStatus, EstimatedChargeRemaining, EstimatedRunTime |
    Format-List | Out-File $Report -Append

"--- DEVICE ERRORS ---" | Out-File $Report -Append
Get-CimInstance Win32_PnPEntity |
    Where-Object { $_.ConfigManagerErrorCode -ne 0 } |
    Select-Object Name, PNPDeviceID, ConfigManagerErrorCode |
    Format-Table -AutoSize | Out-File $Report -Append

"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "System information report created:"
Write-Host $Report
Write-Host ""
