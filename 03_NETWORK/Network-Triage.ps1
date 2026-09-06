# COMPUTER TOOLKIT — NETWORK TRIAGE
# Read-only network troubleshooting.
# Does not modify adapters, DNS, IP settings, routes, or firewall rules.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\03_NETWORK"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("NETWORK_TRIAGE_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — NETWORK TRIAGE" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no network settings changed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- 1. NETWORK ADAPTER STATUS ---" | Out-File $Report -Append

Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed, MacAddress |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- 2. IP CONFIGURATION ---" | Out-File $Report -Append

Get-NetIPConfiguration |
    Select-Object InterfaceAlias, InterfaceIndex,
        IPv4Address, IPv4DefaultGateway,
        DNSServer |
    Format-List |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- 3. IP ADDRESS STATE ---" | Out-File $Report -Append

Get-NetIPAddress |
    Where-Object {$_.AddressFamily -eq "IPv4"} |
    Select-Object InterfaceAlias, IPAddress, PrefixLength, AddressState |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- 4. DEFAULT GATEWAY ---" | Out-File $Report -Append

$Gateways = Get-NetRoute -DestinationPrefix "0.0.0.0/0"

if ($Gateways) {
    $Gateways |
        Select-Object InterfaceAlias, NextHop, RouteMetric |
        Format-Table -AutoSize |
        Out-File $Report -Append
}
else {
    "No IPv4 default gateway reported." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- 5. LOCAL STACK TEST ---" | Out-File $Report -Append

$PingLocal = Test-Connection -ComputerName "127.0.0.1" -Count 2

if ($PingLocal) {
    "PASS — Local TCP/IP stack responded." | Out-File $Report -Append
}
else {
    "FAIL — Local TCP/IP stack did not respond." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- 6. GATEWAY TEST ---" | Out-File $Report -Append

$Gateway = $Gateways |
    Where-Object {$_.NextHop -and $_.NextHop -ne "0.0.0.0"} |
    Select-Object -First 1 -ExpandProperty NextHop

if ($Gateway) {
    $PingGateway = Test-Connection -ComputerName $Gateway -Count 2

    if ($PingGateway) {
        "PASS — Gateway responded: $Gateway" | Out-File $Report -Append
    }
    else {
        "FAIL — Gateway did not respond: $Gateway" | Out-File $Report -Append
    }
}
else {
    "SKIPPED — No gateway identified." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- 7. DNS TEST ---" | Out-File $Report -Append

try {
    $DnsTest = Resolve-DnsName "www.microsoft.com" -ErrorAction Stop

    if ($DnsTest) {
        "PASS — DNS resolution succeeded." | Out-File $Report -Append
        "Resolved addresses:" | Out-File $Report -Append

        $DnsTest |
            Where-Object {$_.IPAddress} |
            Select-Object -ExpandProperty IPAddress |
            Out-File $Report -Append
    }
}
catch {
    "FAIL — DNS resolution failed." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- 8. INTERNET CONNECTION TEST ---" | Out-File $Report -Append

try {
    $Internet = Test-NetConnection -ComputerName "www.microsoft.com" -Port 443

    "Remote address    : $($Internet.RemoteAddress)" | Out-File $Report -Append
    "Interface         : $($Internet.InterfaceAlias)" | Out-File $Report -Append
    "Source address    : $($Internet.SourceAddress)" | Out-File $Report -Append
    "TCP 443 succeeded : $($Internet.TcpTestSucceeded)" | Out-File $Report -Append
}
catch {
    "Internet connectivity test could not be completed." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- TRIAGE INTERPRETATION ---" | Out-File $Report -Append
"Adapter DOWN       -> investigate adapter/Wi-Fi state." | Out-File $Report -Append
"No IPv4 address    -> investigate DHCP or network configuration." | Out-File $Report -Append
"No gateway         -> investigate local network connection." | Out-File $Report -Append
"Gateway fails      -> investigate Wi-Fi/Ethernet/router connection." | Out-File $Report -Append
"DNS fails           -> investigate DNS/name resolution." | Out-File $Report -Append
"DNS works but TCP fails -> investigate Internet/firewall/network policy." | Out-File $Report -Append
"All tests pass      -> problem may be application-specific." | Out-File $Report -Append

"" | Out-File $Report -Append
"IMPORTANT" | Out-File $Report -Append
"These tests provide evidence; they do not automatically identify the cause." | Out-File $Report -Append
"Do not change network settings solely because a test fails." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Network triage report created:"
Write-Host $Report
Write-Host ""
