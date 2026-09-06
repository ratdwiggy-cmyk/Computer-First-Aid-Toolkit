# COMPUTER TOOLKIT — COLLECT SESSION REPORTS
# Copies existing diagnostic reports into the selected session.
# Does NOT delete or modify the original reports.

$Root = "D:\STORAGE_HUB\COMPUTER_TOOLKIT"
$Sessions = "$Root\SESSIONS"

if (-not (Test-Path $Sessions)) {
    Write-Host ""
    Write-Host "No SESSIONS folder exists." -ForegroundColor Yellow
    exit
}

$AvailableSessions = Get-ChildItem $Sessions -Directory |
    Sort-Object Name -Descending

if (-not $AvailableSessions) {
    Write-Host ""
    Write-Host "No sessions have been created yet."
    Write-Host "Use Start-NewSession.ps1 first."
    exit
}

Write-Host ""
Write-Host "============================================================"
Write-Host "       COMPUTER TOOLKIT — COLLECT SESSION REPORTS"
Write-Host "============================================================"
Write-Host ""

for ($i = 0; $i -lt $AvailableSessions.Count; $i++) {
    Write-Host "$($i + 1). $($AvailableSessions[$i].Name)"
}

Write-Host ""
$Selection = Read-Host "Select the session number"

if (-not [int]::TryParse($Selection, [ref]$Index)) {
    Write-Host "Invalid selection."
    exit
}

$Index--

if ($Index -lt 0 -or $Index -ge $AvailableSessions.Count) {
    Write-Host "Invalid session number."
    exit
}

$Session = $AvailableSessions[$Index]
$Destination = $Session.FullName

Write-Host ""
Write-Host "Selected session:"
Write-Host $Destination
Write-Host ""

$Sources = @(
    "$Root\01_SYSTEM_INFO",
    "$Root\02_HARDWARE_DIAGNOSTICS",
    "$Root\03_NETWORK",
    "$Root\05_WINDOWS_REPAIR",
    "$Root\07_SECURITY_CHECKS"
)

$Copied = 0

foreach ($Source in $Sources) {

    if (-not (Test-Path $Source)) {
        continue
    }

    $Files = Get-ChildItem $Source -File -Filter "*.txt"

    foreach ($File in $Files) {

        $Target = Join-Path $Destination $File.Name

        if (Test-Path $Target) {
            $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($File.Name)
            $Extension = $File.Extension
            $Stamp = Get-Date -Format "HHmmss"

            $Target = Join-Path $Destination "${BaseName}_$Stamp$Extension"
        }

        Copy-Item $File.FullName $Target
        $Copied++

        Write-Host "Copied: $($File.Name)"
    }
}

Write-Host ""
Write-Host "============================================================"
Write-Host "Collection complete."
Write-Host "Reports copied: $Copied"
Write-Host "Session: $Destination"
Write-Host "============================================================"
Write-Host ""
Write-Host "Original reports were not deleted or modified."
