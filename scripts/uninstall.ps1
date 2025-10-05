# PowerShell Theme Framework - Uninstallation Script
# This script removes the theme framework from the PowerShell profile

param(
    [switch]$KeepBackup
)

Write-Host "PowerShell Theme Framework - Uninstallation" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

$profilePath = $PROFILE

# Check if profile exists
if (-not (Test-Path $profilePath)) {
    Write-Host "No PowerShell profile found. Nothing to uninstall." -ForegroundColor Yellow
    exit 0
}

# Check if theme framework is installed
$profileContent = Get-Content $profilePath -Raw
$hasFramework = $profileContent -like "*PowerShell Theme Framework*"

if (-not $hasFramework) {
    Write-Host "PowerShell Theme Framework is not installed in your profile." -ForegroundColor Yellow
    exit 0
}

# Backup current profile
$backupPath = "$profilePath.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Write-Host "Creating backup: $backupPath" -ForegroundColor Yellow
Copy-Item $profilePath $backupPath

# Remove theme framework from profile
Write-Host "Removing PowerShell Theme Framework from profile..." -ForegroundColor Green

$lines = $profileContent -split "`n"
$filteredLines = @()
$skipMode = $false

foreach ($line in $lines) {
    if ($line -like "*PowerShell Theme Framework - Auto-generated*") {
        $skipMode = $true
        Write-Host "Found framework installation, removing..." -ForegroundColor Yellow
    }
    elseif ($skipMode -and $line.Trim() -eq "" -and $filteredLines.Count -gt 0) {
        # Potential end of framework section
        $skipMode = $false
    }
    elseif (-not $skipMode) {
        $filteredLines += $line
    }
}

# Write cleaned content back to profile
$cleanContent = $filteredLines -join "`n"
$cleanContent = $cleanContent.TrimEnd()  # Remove trailing whitespace

if ([string]::IsNullOrWhiteSpace($cleanContent)) {
    # If profile is now empty, remove it
    Remove-Item $profilePath
    Write-Host "Profile was empty after removal, deleted profile file." -ForegroundColor Green
}
else {
    Set-Content $profilePath $cleanContent -Encoding UTF8
    Write-Host "Updated profile with framework removed." -ForegroundColor Green
}

# Clean up old backups if requested
if (-not $KeepBackup) {
    $oldBackups = Get-ChildItem -Path (Split-Path $profilePath) -Filter "*.backup.*" | Where-Object { 
        $_.Name -like "Microsoft.PowerShell_profile.ps1.backup.*" -and
        $_.LastWriteTime -lt (Get-Date).AddDays(-7)
    }
    
    if ($oldBackups.Count -gt 0) {
        Write-Host "Cleaning up old backups (older than 7 days)..." -ForegroundColor Yellow
        $oldBackups | Remove-Item -Force
        Write-Host "Removed $($oldBackups.Count) old backup(s)." -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Uninstallation completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Your PowerShell prompt will return to default after:" -ForegroundColor Yellow
Write-Host "1. Restarting PowerShell, or" -ForegroundColor White
Write-Host "2. Running: . `$PROFILE" -ForegroundColor White
Write-Host ""
Write-Host "Backup created at: $backupPath" -ForegroundColor Gray

# Reset prompt function to default
Write-Host "Resetting prompt to default..." -ForegroundColor Yellow
function global:prompt {
    "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
}

Write-Host "Prompt reset to PowerShell default." -ForegroundColor Green