# PowerShell Theme Framework - Main Prompt Function
# This is the main entry point that gets loaded into the PowerShell profile

# Import core modules
$script:PSThemeRoot = Split-Path $PSScriptRoot -Parent
. "$PSScriptRoot\utils.ps1"
. "$PSScriptRoot\renderer.ps1"

# Set the default theme path
$script:PSThemeConfig.ThemesPath = Join-Path $script:PSThemeRoot "themes"
$script:PSThemeConfig.ModulesPath = Join-Path $script:PSThemeRoot "modules"

function prompt {
    try {
        # Save current error action preference
        $previousErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = 'SilentlyContinue'
        
        # Get the rendered prompt
        $promptText = Render-Prompt -ThemeName $script:PSThemeConfig.CurrentTheme
        
        # Restore error action preference
        $ErrorActionPreference = $previousErrorActionPreference
        
        # Return the prompt text
        return $promptText
    }
    catch {
        # Fallback to default prompt if there's an error
        Write-Warning "Theme rendering error: $_"
        return "PS $($executionContext.SessionState.Path.CurrentLocation)> "
    }
}

function Set-PSTheme {
    <#
    .SYNOPSIS
        Sets the active PowerShell theme
        
    .DESCRIPTION
        Changes the current PowerShell theme to the specified theme name.
        The theme must exist in the themes directory.
        
    .PARAMETER ThemeName
        The name of the theme to activate (without .json extension)
        
    .EXAMPLE
        Set-PSTheme -ThemeName "retro-neon"
        
    .EXAMPLE
        Set-PSTheme "minimal"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$ThemeName
    )
    
    Set-CurrentTheme -ThemeName $ThemeName
}

function Get-PSThemes {
    <#
    .SYNOPSIS
        Lists all available PowerShell themes
        
    .DESCRIPTION
        Returns a list of all available theme files in the themes directory
        
    .EXAMPLE
        Get-PSThemes
    #>
    
    $themesPath = $script:PSThemeConfig.ThemesPath
    
    if (Test-Path $themesPath) {
        $themeFiles = Get-ChildItem -Path $themesPath -Filter "*.json"
        $themes = $themeFiles | ForEach-Object { 
            [PSCustomObject]@{
                Name = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
                Path = $_.FullName
                Current = ([System.IO.Path]::GetFileNameWithoutExtension($_.Name) -eq $script:PSThemeConfig.CurrentTheme)
            }
        }
        return $themes
    }
    else {
        Write-Warning "Themes directory not found: $themesPath"
        return @()
    }
}

function Get-PSThemeInfo {
    <#
    .SYNOPSIS
        Gets information about the current theme configuration
        
    .DESCRIPTION
        Returns detailed information about the currently active theme,
        including available blocks and configuration settings
        
    .EXAMPLE
        Get-PSThemeInfo
    #>
    
    $currentTheme = $script:PSThemeConfig.CurrentTheme
    $themeConfig = Get-ThemeConfig -ThemeName $currentTheme
    
    if ($themeConfig) {
        return [PSCustomObject]@{
            CurrentTheme = $currentTheme
            ThemesPath = $script:PSThemeConfig.ThemesPath
            ModulesPath = $script:PSThemeConfig.ModulesPath
            SupportsAnsi = $script:PSThemeConfig.SupportsAnsi
            BlockCount = $themeConfig.blocks.Count
            EnabledBlocks = ($themeConfig.blocks | Where-Object { $_.enabled -ne $false }).Count
            ThemeConfig = $themeConfig
        }
    }
    else {
        Write-Error "Could not load theme information for '$currentTheme'"
        return $null
    }
}

function Test-PSThemeSetup {
    <#
    .SYNOPSIS
        Tests the PowerShell theme framework setup
        
    .DESCRIPTION
        Validates that all required directories and files exist for the theme framework
        
    .EXAMPLE
        Test-PSThemeSetup
    #>
    
    $results = @{
        ThemesDirectory = Test-Path $script:PSThemeConfig.ThemesPath
        ModulesDirectory = Test-Path $script:PSThemeConfig.ModulesPath
        DefaultTheme = Test-Path (Join-Path $script:PSThemeConfig.ThemesPath "default.json")
        AnsiSupport = $script:PSThemeConfig.SupportsAnsi
        Issues = @()
    }
    
    if (-not $results.ThemesDirectory) {
        $results.Issues += "Themes directory not found: $($script:PSThemeConfig.ThemesPath)"
    }
    
    if (-not $results.ModulesDirectory) {
        $results.Issues += "Modules directory not found: $($script:PSThemeConfig.ModulesPath)"
    }
    
    if (-not $results.DefaultTheme) {
        $results.Issues += "Default theme not found"
    }
    
    if (-not $results.AnsiSupport) {
        $results.Issues += "Terminal does not support ANSI colors (themes will use fallback mode)"
    }
    
    $results.IsHealthy = $results.Issues.Count -eq 0 -or ($results.Issues.Count -eq 1 -and $results.Issues[0] -like "*ANSI*")
    
    return [PSCustomObject]$results
}

# Welcome message when theme is loaded
Write-Host "PowerShell Theme Framework loaded!" -ForegroundColor Cyan
Write-Host "Current theme: $($script:PSThemeConfig.CurrentTheme)" -ForegroundColor Yellow
Write-Host "Use 'Get-PSThemes' to see available themes or 'Set-PSTheme <name>' to change themes." -ForegroundColor Gray

# Functions are available globally when dot-sourced