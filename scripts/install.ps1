# PowerShell Theme Framework - Installation Script
# This script installs the theme framework into the PowerShell profile

param(
    [string]$ThemeName = "default",
    [switch]$Force
)

Write-Host "PowerShell Theme Framework - Installation" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Get script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

# Validate theme framework structure
$requiredPaths = @(
    Join-Path $projectRoot "core\prompt.ps1"
    Join-Path $projectRoot "core\renderer.ps1" 
    Join-Path $projectRoot "core\utils.ps1"
    Join-Path $projectRoot "themes\$ThemeName.json"
)

foreach ($path in $requiredPaths) {
    if (-not (Test-Path $path)) {
        Write-Error "Required file not found: $path"
        Write-Host "Installation failed. Please ensure all theme framework files are present." -ForegroundColor Red
        exit 1
    }
}

# Check PowerShell profile
$profilePath = $PROFILE
$profileDir = Split-Path -Parent $profilePath

Write-Host "Profile path: $profilePath" -ForegroundColor Yellow

# Create profile directory if it doesn't exist
if (-not (Test-Path $profileDir)) {
    Write-Host "Creating profile directory..." -ForegroundColor Green
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Check if profile already has theme framework
$hasFramework = $false
if (Test-Path $profilePath) {
    $profileContent = Get-Content $profilePath -Raw
    $hasFramework = $profileContent -like "*PowerShell Theme Framework*"
}

if ($hasFramework -and -not $Force) {
    Write-Host "PowerShell Theme Framework is already installed in your profile." -ForegroundColor Yellow
    Write-Host "Use -Force parameter to reinstall or run uninstall.ps1 first." -ForegroundColor Yellow
    exit 0
}

# Backup existing profile
if (Test-Path $profilePath) {
    $backupPath = "$profilePath.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Host "Backing up existing profile to: $backupPath" -ForegroundColor Yellow
    Copy-Item $profilePath $backupPath
}

# Create installation content
$installContent = @"
# PowerShell Theme Framework - Auto-generated
# Generated on: $(Get-Date)
# Framework location: $projectRoot

# Load the PowerShell Theme Framework
`$script:PSThemeFrameworkRoot = "$projectRoot"
if (Test-Path "`$script:PSThemeFrameworkRoot\core\prompt.ps1") {
    . "`$script:PSThemeFrameworkRoot\core\prompt.ps1"
    
    # The theme framework will automatically load the saved theme from config
    # If no saved theme exists, it will default to "$ThemeName"
} else {
    Write-Warning "PowerShell Theme Framework not found at: `$script:PSThemeFrameworkRoot"
}

"@

# Append to or create profile
if (Test-Path $profilePath) {
    if ($Force) {
        # Remove existing framework installation
        $existingContent = Get-Content $profilePath -Raw
        $lines = $existingContent -split "`n"
        $filteredLines = @()
        $skipMode = $false
        
        foreach ($line in $lines) {
            if ($line -like "*PowerShell Theme Framework - Auto-generated*") {
                $skipMode = $true
            }
            elseif ($skipMode -and $line.Trim() -eq "") {
                # End of framework section
                $skipMode = $false
            }
            elseif (-not $skipMode) {
                $filteredLines += $line
            }
        }
        
        $cleanContent = $filteredLines -join "`n"
        $installContent = $cleanContent + "`n`n" + $installContent
        Set-Content $profilePath $installContent -Encoding UTF8
    }
    else {
        Add-Content $profilePath "`n$installContent" -Encoding UTF8
    }
}
else {
    Set-Content $profilePath $installContent -Encoding UTF8
}

Write-Host ""
Write-Host "Installation completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Restart PowerShell or run: . `$PROFILE" -ForegroundColor White
Write-Host "2. Use 'Get-PSThemes' to see available themes" -ForegroundColor White
Write-Host "3. Use 'Set-PSTheme <name>' to change themes" -ForegroundColor White
Write-Host "4. Use 'Test-PSThemeSetup' to verify installation" -ForegroundColor White
Write-Host ""
Write-Host "Default theme '$ThemeName' has been configured." -ForegroundColor Green

# Test installation
Write-Host "Testing installation..." -ForegroundColor Yellow
try {
    . $profilePath
    Write-Host "Installation test passed!" -ForegroundColor Green
}
catch {
    Write-Warning "Installation test failed: $_"
    Write-Host "You may need to restart PowerShell to use the theme framework." -ForegroundColor Yellow
}