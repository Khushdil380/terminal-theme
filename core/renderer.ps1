# PowerShell Theme Framework - Main Renderer
# Central dispatcher to theme-specific renderers

# Import utilities and theme manager
. "$PSScriptRoot\utils.ps1"
. "$PSScriptRoot\theme-manager.ps1"

function Render-Prompt {
    param([string]$ThemeName = $global:PSThemeConfig.CurrentTheme)
    
    $themeConfig = Get-ThemeConfig -ThemeName $ThemeName
    if (-not $themeConfig) {
        return "PS> "
    }
    
    # Use the central theme manager - pass the theme name
    return Invoke-ThemeRenderer -ThemeName $ThemeName
}

function Set-CurrentTheme {
    param([string]$ThemeName)
    
    $themePath = Join-Path $global:PSThemeConfig.ThemesPath "$ThemeName.json"
    
    if (Test-Path $themePath) {
        $global:PSThemeConfig.CurrentTheme = $ThemeName
        
        # Save theme preference to persistent storage
        Save-CurrentTheme -ThemeName $ThemeName | Out-Null
        
        Write-Host "Theme changed to: $ThemeName" -ForegroundColor Green
        return $true
    }
    else {
        Write-Error "Theme '$ThemeName' not found."
        return $false
    }
}

# Functions are available globally when dot-sourced