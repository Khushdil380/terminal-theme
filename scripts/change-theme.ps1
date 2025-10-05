# PowerShell Theme Framework - Change Theme Script
# This script allows easy switching between themes

param(
    [Parameter(Mandatory=$true)]
    [string]$Theme,
    [switch]$List,
    [switch]$Preview
)

Write-Host "PowerShell Theme Framework - Theme Changer" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan

# Get script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$themesPath = Join-Path $projectRoot "themes"

# Function to list available themes
function Show-AvailableThemes {
    Write-Host "Available themes:" -ForegroundColor Yellow
    Write-Host ""
    
    if (Test-Path $themesPath) {
        $themeFiles = Get-ChildItem -Path $themesPath -Filter "*.json"
        
        foreach ($themeFile in $themeFiles) {
            $themeName = [System.IO.Path]::GetFileNameWithoutExtension($themeFile.Name)
            
            try {
                $themeContent = Get-Content $themeFile.FullName -Raw | ConvertFrom-Json
                $displayName = if ($themeContent.name) { $themeContent.name } else { $themeName }
                $description = if ($themeContent.description) { $themeContent.description } else { "No description" }
                
                Write-Host "  $themeName" -ForegroundColor Green -NoNewline
                Write-Host " - $displayName" -ForegroundColor White
                Write-Host "    $description" -ForegroundColor Gray
                
                # Show block count
                $blockCount = if ($themeContent.blocks) { $themeContent.blocks.Count } else { 0 }
                $enabledBlocks = if ($themeContent.blocks) { 
                    ($themeContent.blocks | Where-Object { $_.enabled -ne $false }).Count 
                } else { 0 }
                Write-Host "    Blocks: $enabledBlocks/$blockCount enabled" -ForegroundColor DarkGray
                Write-Host ""
            }
            catch {
                Write-Host "  $themeName" -ForegroundColor Red -NoNewline
                Write-Host " - Error loading theme" -ForegroundColor Red
                Write-Host ""
            }
        }
    }
    else {
        Write-Host "Themes directory not found: $themesPath" -ForegroundColor Red
    }
}

# Function to preview a theme
function Show-ThemePreview {
    param([string]$ThemeName)
    
    $themeFile = Join-Path $themesPath "$ThemeName.json"
    
    if (-not (Test-Path $themeFile)) {
        Write-Host "Theme '$ThemeName' not found." -ForegroundColor Red
        return
    }
    
    try {
        $themeContent = Get-Content $themeFile -Raw | ConvertFrom-Json
        
        Write-Host "Theme Preview: $ThemeName" -ForegroundColor Yellow
        Write-Host "================================" -ForegroundColor Yellow
        Write-Host "Name: $($themeContent.name)" -ForegroundColor White
        Write-Host "Description: $($themeContent.description)" -ForegroundColor Gray
        Write-Host "Version: $($themeContent.version)" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Blocks:" -ForegroundColor Yellow
        
        foreach ($block in $themeContent.blocks) {
            $status = if ($block.enabled -eq $false) { "(disabled)" } else { "" }
            $icon = if ($block.icon) { $block.icon } else { "" }
            
            Write-Host "  - $($block.type) $status" -ForegroundColor White
            Write-Host "    Icon: $icon" -ForegroundColor Gray
            Write-Host "    Colors: fg=$($block.foreground), bg=$($block.background)" -ForegroundColor Gray
            
            if ($block.template) {
                Write-Host "    Template: $($block.template)" -ForegroundColor Gray
            }
            Write-Host ""
        }
    }
    catch {
        Write-Host "Error loading theme preview: $_" -ForegroundColor Red
    }
}

# Handle list parameter
if ($List) {
    Show-AvailableThemes
    exit 0
}

# Handle preview parameter
if ($Preview) {
    Show-ThemePreview -ThemeName $Theme
    exit 0
}

# Validate theme exists
$themeFile = Join-Path $themesPath "$Theme.json"
if (-not (Test-Path $themeFile)) {
    Write-Host "Theme '$Theme' not found." -ForegroundColor Red
    Write-Host ""
    Show-AvailableThemes
    exit 1
}

# Check if PowerShell Theme Framework is loaded
if (-not (Get-Command "Set-PSTheme" -ErrorAction SilentlyContinue)) {
    Write-Host "PowerShell Theme Framework is not loaded." -ForegroundColor Red
    Write-Host "Please run install.ps1 first or restart PowerShell." -ForegroundColor Yellow
    exit 1
}

# Change theme
Write-Host "Changing theme to: $Theme" -ForegroundColor Green

try {
    Set-PSTheme -ThemeName $Theme
    Write-Host "Theme changed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "New prompt preview:" -ForegroundColor Yellow
    Write-Host (prompt) -NoNewline
    Write-Host ""
}
catch {
    Write-Host "Failed to change theme: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Theme '$Theme' is now active." -ForegroundColor Green
Write-Host "The change will persist for this session." -ForegroundColor Gray
Write-Host "To make it permanent, run: install.ps1 -ThemeName $Theme -Force" -ForegroundColor Gray