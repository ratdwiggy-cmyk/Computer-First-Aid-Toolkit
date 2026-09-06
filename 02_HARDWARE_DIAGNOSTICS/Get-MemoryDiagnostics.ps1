# COMPUTER TOOLKIT — MEMORY DIAGNOSTICS
# Read-only memory information.
# Does not modify RAM, BIOS, firmware, or Windows configuration.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\02_HARDWARE_DIAGNOSTICS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("MEMORY_DIAGNOSTICS_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — MEMORY DIAGNOSTICS" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no hardware changes performed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- WINDOWS MEMORY SUMMARY ---" | Out-File $Report -Append

$OS = Get-CimInstance Win32_OperatingSystem

"Total Physical Memory : $([math]::Round($OS.TotalVisibleMemorySize / 1MB, 2)) GB" | Out-File $Report -Append
"Free Physical Memory  : $([math]::Round($OS.FreePhysicalMemory / 1MB, 2)) GB" | Out-File $Report -Append
"Memory Usage          : $([math]::Round((1 - ($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize)) * 100, 1)) %" | Out-File $Report -Append
"" | Out-File $Report -Append

"--- MEMORY MODULES ---" | Out-File $Report -Append

Get-CimInstance Win32_PhysicalMemory |
    Select-Object DeviceLocator, Manufacturer, PartNumber,
        @{Name="CapacityGB";Expression={[math]::Round($_.Capacity / 1GB, 2)}},
        Speed, ConfiguredClockSpeed, SerialNumber |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- MEMORY ARRAY ---" | Out-File $Report -Append

Get-CimInstance Win32_PhysicalMemoryArray |
    Select-Object MemoryDevices, MaxCapacity |
    Format-List |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- WINDOWS MEMORY DEVICE STATUS ---" | Out-File $Report -Append

Get-CimInstance Win32_PhysicalMemory |
    Select-Object DeviceLocator, Status |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"This report identifies installed memory and Windows-reported status." | Out-File $Report -Append
"A normal status does not prove that RAM will pass an extended memory test." | Out-File $Report -Append
"If memory errors are suspected, use a dedicated memory test before replacing hardware." | Out-File $Report -Append
"Do not change BIOS/UEFI memory settings during basic diagnosis." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Memory diagnostic report created:"
Write-Host $Report
Write-Host ""
