# COMPUTER TOOLKIT — WINDOWS SECURITY ASSESSMENT
# Read-only security inspection.
# Does NOT disable security, bypass controls, remove malware,
# reset passwords, or change firewall/Defender settings.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\07_SECURITY_CHECKS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("SECURITY_ASSESSMENT_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — WINDOWS SECURITY ASSESSMENT" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY assessment — no security settings changed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- WINDOWS SECURITY CENTER ---" | Out-File $Report -Append

try {
    Get-CimInstance -Namespace "root\SecurityCenter2" -ClassName AntiVirusProduct |
        Select-Object DisplayName, ProductState, PathToSignedProductExe |
        Format-List |
        Out-File $Report -Append
}
catch {
    "Antivirus information could not be queried." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- MICROSOFT DEFENDER STATUS ---" | Out-File $Report -Append

try {
    Get-MpComputerStatus |
        Select-Object AMServiceEnabled,
            AntivirusEnabled,
            AntispywareEnabled,
            BehaviorMonitorEnabled,
            IoavProtectionEnabled,
            RealTimeProtectionEnabled,
            NISEnabled,
            IsTamperProtected,
            AntivirusSignatureLastUpdated,
            AntispywareSignatureLastUpdated |
        Format-List |
        Out-File $Report -Append
}
catch {
    "Microsoft Defender status could not be queried." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- FIREWALL PROFILE STATUS ---" | Out-File $Report -Append

try {
    Get-NetFirewallProfile |
        Select-Object Name, Enabled, DefaultInboundAction,
            DefaultOutboundAction |
        Format-Table -AutoSize |
        Out-File $Report -Append
}
catch {
    "Firewall status could not be queried." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- WINDOWS UPDATE SERVICE ---" | Out-File $Report -Append

Get-Service -Name wuauserv |
    Select-Object Name, Status, StartType |
    Format-List |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- SECURITY-RELATED DEVICE ERRORS ---" | Out-File $Report -Append

$SecurityErrors = Get-CimInstance Win32_PnPEntity |
    Where-Object {
        $_.ConfigManagerErrorCode -ne 0 -and
        $_.Name -match "security|tpm|trusted|crypt|smart card"
    } |
    Select-Object Name, Status, ConfigManagerErrorCode

if ($SecurityErrors) {
    $SecurityErrors |
        Format-List |
        Out-File $Report -Append
}
else {
    "No security-related Plug and Play device errors reported." |
        Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- TPM ---" | Out-File $Report -Append

try {
    Get-Tpm |
        Select-Object TpmPresent, TpmReady, TpmEnabled,
            TpmActivated, ManagedAuthLevel |
        Format-List |
        Out-File $Report -Append
}
catch {
    "TPM information could not be queried." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"This report records Windows security configuration; it is not a malware verdict." | Out-File $Report -Append
"A disabled security feature may be intentional in some environments." | Out-File $Report -Append
"Do not disable Defender, firewall, tamper protection, or other security controls merely because a diagnostic reports a setting." | Out-File $Report -Append
"Do not bypass passwords, BitLocker, administrator restrictions, or endpoint security." | Out-File $Report -Append
"Unexpected security changes should be investigated before attempting remediation." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Security assessment created:"
Write-Host $Report
Write-Host ""
