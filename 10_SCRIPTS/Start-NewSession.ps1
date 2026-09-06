# COMPUTER TOOLKIT — START NEW SESSION
# Creates a dated session folder only.
# Does not inspect or modify the computer being diagnosed.

$Sessions = "D:\STORAGE_HUB\COMPUTER_TOOLKIT\SESSIONS"

if (-not (Test-Path $Sessions)) {
    New-Item -Path $Sessions -ItemType Directory -Force | Out-Null
}

$Date = Get-Date -Format "yyyy-MM-dd_HHmm"
$Folder = Join-Path $Sessions $Date

$Counter = 1

while (Test-Path $Folder) {
    $Folder = Join-Path $Sessions ("{0}_COMPUTER{1:D2}" -f $Date, $Counter)
    $Counter++
}

New-Item -Path $Folder -ItemType Directory -Force | Out-Null

@"
COMPUTER TOOLKIT — SESSION
==========================

Session:
$(Split-Path $Folder -Leaf)

Started:
$(Get-Date)

Computer owner / organization:

Technician / helper:

Permission to inspect:
[ ] Yes
[ ] No

Permission to make changes:
[ ] Yes
[ ] No
[ ] Limited

Reported problem:

____________________________________________________________

Important data involved?
[ ] Yes
[ ] No
[ ] Unknown

Known backup?
[ ] Yes
[ ] No
[ ] Unknown

Computer model:

Operating system:

Notes:

____________________________________________________________

____________________________________________________________

"@ | Set-Content (Join-Path $Folder "SESSION_NOTES.txt")

Write-Host ""
Write-Host "New toolkit session created:"
Write-Host $Folder
Write-Host ""
Write-Host "Session notes:"
Write-Host (Join-Path $Folder "SESSION_NOTES.txt")
