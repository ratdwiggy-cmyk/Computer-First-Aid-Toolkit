# COMPUTER TOOLKIT — SAFE FILE BACKUP
# Copies files from a selected source to a selected destination.
# Does NOT delete, move, format, or modify the source.
#
# IMPORTANT:
# Always verify SOURCE and DESTINATION before starting.
# Never use the affected drive as the recovery destination.

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================"
Write-Host " COMPUTER TOOLKIT — SAFE FILE BACKUP"
Write-Host "========================================"
Write-Host ""
Write-Host "This tool COPIES files."
Write-Host "It does NOT delete or move the source files."
Write-Host ""
Write-Host "IMPORTANT: Verify the source and destination carefully."
Write-Host ""

$Source = Read-Host "Enter the SOURCE folder path"
$Destination = Read-Host "Enter the DESTINATION folder path"

if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
    Write-Host ""
    Write-Host "ERROR: Source folder does not exist." -ForegroundColor Red
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Destination)) {
    Write-Host ""
    Write-Host "ERROR: Destination cannot be empty." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "SOURCE:"
Write-Host $Source
Write-Host ""
Write-Host "DESTINATION:"
Write-Host $Destination
Write-Host ""
Write-Host "The source will NOT be deleted or moved."
Write-Host ""

$Confirm = Read-Host "Type CONFIRM to start the copy"

if ($Confirm -ne "CONFIRM") {
    Write-Host ""
    Write-Host "Cancelled. No files were copied."
    exit 0
}

try {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null

    $SourceName = Split-Path $Source -Leaf

    if ([string]::IsNullOrWhiteSpace($SourceName)) {
        $SourceName = "BACKUP"
    }

    $Target = Join-Path $Destination $SourceName

    Write-Host ""
    Write-Host "Copying files..."
    Write-Host ""

    Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force

    Write-Host ""
    Write-Host "BACKUP COMPLETE"
    Write-Host ""
    Write-Host "Destination:"
    Write-Host $Target
}
catch {
    Write-Host ""
    Write-Host "BACKUP ERROR:" -ForegroundColor Red
    Write-Host $_.Exception.Message
    Write-Host ""
    Write-Host "The source files were not intentionally deleted or moved."
}
