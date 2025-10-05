# PowerShell Theme Framework - Apply Theme Script
# This script applies/reloads the current theme configuration

param(
    [string]$ThemeName = $null
)

Write-Host "PowerShell Theme Framework - Apply Theme" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Check if PowerShell Theme Framework is loaded
if (-not (Get-Command "Set-PSTheme" -ErrorAction SilentlyContinue)) {
    Write-Host "PowerShell Theme Framework is not loaded." -ForegroundColor Red
    Write-Host "Please run install.ps1 first or restart PowerShell." -ForegroundColor Yellow
    exit 1
}

# Get current theme if none specified
if (-not $ThemeName) {
    try {
        $themeInfo = Get-PSThemeInfo
        $ThemeName = $themeInfo.CurrentTheme
        Write-Host "No theme specified, reloading current theme: $ThemeName" -ForegroundColor Yellow
    }
    catch {
        Write-Host "Could not determine current theme, using default." -ForegroundColor Yellow
        $ThemeName = "default"
    }
}

# Validate theme exists
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$themeFile = Join-Path $projectRoot "themes\$ThemeName.json"

if (-not (Test-Path $themeFile)) {
    Write-Host "Theme '$ThemeName' not found at: $themeFile" -ForegroundColor Red
    
    # Show available themes
    Write-Host ""
    Write-Host "Available themes:" -ForegroundColor Yellow
    $themesPath = Join-Path $projectRoot "themes"
    if (Test-Path $themesPath) {
        Get-ChildItem -Path $themesPath -Filter "*.json" | ForEach-Object {
            $name = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
            Write-Host "  - $name" -ForegroundColor White
        }
    }
    exit 1
}

# Apply the theme
Write-Host "Applying theme: $ThemeName" -ForegroundColor Green

try {
    # Force reload the theme configuration
    Set-PSTheme -ThemeName $ThemeName
    
    Write-Host "Theme applied successfully!" -ForegroundColor Green
    Write-Host ""
    
    # Show theme info
    $themeInfo = Get-PSThemeInfo
    Write-Host "Theme Information:" -ForegroundColor Yellow
    Write-Host "  Current Theme: $($themeInfo.CurrentTheme)" -ForegroundColor White
    Write-Host "  Block Count: $($themeInfo.BlockCount)" -ForegroundColor White
    Write-Host "  Enabled Blocks: $($themeInfo.EnabledBlocks)" -ForegroundColor White
    Write-Host "  ANSI Support: $($themeInfo.SupportsAnsi)" -ForegroundColor White
    
    Write-Host ""
    Write-Host "New prompt preview:" -ForegroundColor Yellow
    Write-Host (prompt) -NoNewline
    Write-Host ""
}
catch {
    Write-Host "Failed to apply theme: $_" -ForegroundColor Red
    Write-Host ""
    
    # Run setup test
    Write-Host "Running setup diagnostics..." -ForegroundColor Yellow
    try {
        $setupTest = Test-PSThemeSetup
        if (-not $setupTest.IsHealthy) {
            Write-Host "Setup Issues Found:" -ForegroundColor Red
            foreach ($issue in $setupTest.Issues) {
                Write-Host "  - $issue" -ForegroundColor Red
            }
        }
        else {
            Write-Host "Setup appears healthy. The issue may be with the specific theme." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "Could not run setup diagnostics: $_" -ForegroundColor Red
    }
    
    exit 1
}

Write-Host ""
Write-Host "Theme '$ThemeName' has been applied successfully." -ForegroundColor Green