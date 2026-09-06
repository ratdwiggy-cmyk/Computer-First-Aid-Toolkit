# COMPUTER TOOLKIT — NETWORK DIAGNOSTICS
# Read-only network inspection.
# Does not change adapters, DNS, routes, firewall, or network settings.

$ErrorActionPreference = "SilentlyContinue"

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\02_HARDWARE_DIAGNOSTICS"
New-Item -Path $Root -ItemType Directory -Force | Out-Null

$Report = Join-Path $Root ("NETWORK_DIAGNOSTICS_{0}.txt" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

"========================================" | Out-File $Report
"COMPUTER TOOLKIT — NETWORK DIAGNOSTICS" | Out-File $Report -Append
"========================================" | Out-File $Report -Append
"Generated: $(Get-Date)" | Out-File $Report -Append
"READ-ONLY diagnostic — no network settings changed." | Out-File $Report -Append
"" | Out-File $Report -Append

"--- NETWORK ADAPTERS ---" | Out-File $Report -Append

Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed, MacAddress |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- IP CONFIGURATION ---" | Out-File $Report -Append

Get-NetIPConfiguration |
    Select-Object InterfaceAlias, InterfaceIndex, IPv4Address,
        IPv6Address, IPv4DefaultGateway, DNSServer |
    Format-List |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- IP ADDRESSES ---" | Out-File $Report -Append

Get-NetIPAddress |
    Where-Object {$_.AddressFamily -in "IPv4","IPv6"} |
    Select-Object InterfaceAlias, AddressFamily, IPAddress,
        PrefixLength, AddressState |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- DEFAULT ROUTES ---" | Out-File $Report -Append

Get-NetRoute |
    Where-Object {$_.DestinationPrefix -in "0.0.0.0/0","::/0"} |
    Select-Object InterfaceAlias, DestinationPrefix, NextHop, RouteMetric |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- DNS CONFIGURATION ---" | Out-File $Report -Append

Get-DnsClientServerAddress |
    Where-Object {$_.AddressFamily -in 2,23} |
    Select-Object InterfaceAlias, AddressFamily, ServerAddresses |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- WINDOWS NETWORK PROFILE ---" | Out-File $Report -Append

Get-NetConnectionProfile |
    Select-Object Name, InterfaceAlias, NetworkCategory,
        IPv4Connectivity, IPv6Connectivity |
    Format-Table -AutoSize |
    Out-File $Report -Append

"" | Out-File $Report -Append
"--- CONNECTIVITY TEST ---" | Out-File $Report -Append

try {
    $InternetTest = Test-NetConnection -ComputerName "www.microsoft.com" -Port 443

    "ComputerName       : $($InternetTest.ComputerName)" | Out-File $Report -Append
    "RemoteAddress      : $($InternetTest.RemoteAddress)" | Out-File $Report -Append
    "RemotePort         : $($InternetTest.RemotePort)" | Out-File $Report -Append
    "InterfaceAlias     : $($InternetTest.InterfaceAlias)" | Out-File $Report -Append
    "SourceAddress      : $($InternetTest.SourceAddress)" | Out-File $Report -Append
    "TcpTestSucceeded   : $($InternetTest.TcpTestSucceeded)" | Out-File $Report -Append
}
catch {
    "Connectivity test could not be completed." | Out-File $Report -Append
}

"" | Out-File $Report -Append
"--- INTERPRETATION NOTES ---" | Out-File $Report -Append
"Adapter status identifies whether Windows currently sees the adapter as operational." | Out-File $Report -Append
"IP configuration helps identify DHCP, gateway, and addressing problems." | Out-File $Report -Append
"DNS information helps distinguish name-resolution problems from general connectivity problems." | Out-File $Report -Append
"The connectivity test requires Internet access and may be affected by firewalls or network policies." | Out-File $Report -Append
"Do not change network settings during basic diagnosis unless the owner has authorized the change." | Out-File $Report -Append

"" | Out-File $Report -Append
"--- END OF REPORT ---" | Out-File $Report -Append

Write-Host ""
Write-Host "Network diagnostic report created:"
Write-Host $Report
Write-Host ""
