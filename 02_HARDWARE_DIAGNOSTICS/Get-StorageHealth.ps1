# COMPUTER TOOLKIT — STORAGE HEALTH
# Read-only storage diagnostic.
# Does not repair, format, partition, optimize, or modify disks.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\02_HARDWARE_DIAGNOSTICS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("STORAGE_HEALTH_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

function Show-Value {
    param($Value)
    if ($null -eq $Value -or "$Value" -eq "") {
        return "Not Reported"
    }
    return "$Value"
}

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — STORAGE HEALTH" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no disk changes performed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- PHYSICAL DISKS ---" | Out-File $Report -Append

Get-Disk |
    Select-Object Number, FriendlyName, SerialNumber, BusType, MediaType,
        PartitionStyle, OperationalStatus, HealthStatus, Size, IsBoot, IsSystem |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- DETAILED RELIABILITY INFORMATION ---" | Out-File $Report -Append

foreach ($Disk in Get-PhysicalDisk) {

    $Counter = Get-StorageReliabilityCounter -PhysicalDisk $Disk

    "" | Out-File $Report -Append
    "----------------------------------------" | Out-File $Report -Append
    "Disk Number     : $($Disk.DeviceId)" | Out-File $Report -Append
    "Model           : $($Disk.FriendlyName)" | Out-File $Report -Append
    "Serial          : $($Disk.SerialNumber)" | Out-File $Report -Append
    "Bus             : $($Disk.BusType)" | Out-File $Report -Append
    "Media Type      : $($Disk.MediaType)" | Out-File $Report -Append
    "Health Status    : $($Disk.HealthStatus)" | Out-File $Report -Append
    "Operational      : $($Disk.OperationalStatus)" | Out-File $Report -Append

    if ($Counter) {
        "Temperature     : $(Show-Value $Counter.Temperature) °C" | Out-File $Report -Append
        "Max Temperature : $(Show-Value $Counter.TemperatureMax) °C" | Out-File $Report -Append
        "Wear            : $(Show-Value $Counter.Wear)" | Out-File $Report -Append

        "Read Errors Corrected    : $(Show-Value $Counter.ReadErrorsCorrected)" | Out-File $Report -Append
        "Read Errors Total       : $(Show-Value $Counter.ReadErrorsTotal)" | Out-File $Report -Append
        "Read Errors Uncorrected : $(Show-Value $Counter.ReadErrorsUncorrected)" | Out-File $Report -Append

        "Write Errors Corrected    : $(Show-Value $Counter.WriteErrorsCorrected)" | Out-File $Report -Append
        "Write Errors Total       : $(Show-Value $Counter.WriteErrorsTotal)" | Out-File $Report -Append
        "Write Errors Uncorrected : $(Show-Value $Counter.WriteErrorsUncorrected)" | Out-File $Report -Append

        "Max Read Latency  : $(Show-Value $Counter.ReadLatencyMax) ms" | Out-File $Report -Append
        "Max Write Latency : $(Show-Value $Counter.WriteLatencyMax) ms" | Out-File $Report -Append
        "Max Flush Latency : $(Show-Value $Counter.FlushLatencyMax) ms" | Out-File $Report -Append
        "Power-On Hours    : $(Show-Value $Counter.PowerOnHours)" | Out-File $Report -Append
    }
    else {
        "Reliability Data : Not Reported" | Out-File $Report -Append
    }
}

"" | Out-File $Report -Append
"--- VOLUMES ---" | Out-File $Report -Append

Get-Volume |
    Select-Object DriveLetter, FileSystemLabel, FileSystem,
        HealthStatus, OperationalStatus, Size, SizeRemaining |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- PARTITIONS ---" | Out-File $Report -Append

Get-Partition |
    Select-Object DiskNumber, PartitionNumber, DriveLetter, Type, Size, Offset |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"Healthy/Online means Windows currently considers the device operational." | Out-File $Report -Append
"Not Reported means the hardware/driver did not expose that metric." | Out-File $Report -Append
"Not Reported is NOT the same as zero." | Out-File $Report -Append
"Temperature and error values are evidence to investigate, not automatic diagnoses." | Out-File $Report -Append
"Identify the physical disk before any repair or recovery operation." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Storage health report created:"
Write-Host $Report
Write-Host ""
