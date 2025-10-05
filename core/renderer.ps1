# PowerShell Theme Framework - Renderer
# Handles rendering blocks based on theme configuration

# Import utilities
. "$PSScriptRoot\utils.ps1"

function Get-ThemeConfig {
    param([string]$ThemeName = $script:PSThemeConfig.CurrentTheme)
    
    $themePath = Join-Path $script:PSThemeConfig.ThemesPath "$ThemeName.json"
    
    if (-not (Test-Path $themePath)) {
        Write-Warning "Theme '$ThemeName' not found. Using default theme."
        $themePath = Join-Path $script:PSThemeConfig.ThemesPath "default.json"
    }
    
    try {
        $themeContent = Get-Content $themePath -Raw | ConvertFrom-Json
        return $themeContent
    }
    catch {
        Write-Error "Failed to load theme configuration: $_"
        return $null
    }
}

function Invoke-BlockModule {
    param(
        [string]$BlockName,
        [object]$BlockConfig,
        [object]$ThemeConfig
    )
    
    $modulePath = Join-Path $script:PSThemeConfig.ModulesPath "$BlockName.ps1"
    
    if (-not (Test-Path $modulePath)) {
        Write-Warning "Module '$BlockName' not found at $modulePath"
        return $null
    }
    
    try {
        # Dot source the module and execute its Get-Block function
        . $modulePath
        $functionName = "Get-${BlockName}Block"
        
        if (Get-Command $functionName -ErrorAction SilentlyContinue) {
            return & $functionName -Config $BlockConfig -ThemeConfig $ThemeConfig
        }
        else {
            Write-Warning "Function '$functionName' not found in module '$BlockName'"
            return $null
        }
    }
    catch {
        Write-Error "Error executing module '$BlockName': $_"
        return $null
    }
}

function Render-Block {
    param(
        [object]$Block,
        [object]$ThemeConfig,
        [string]$Content,
        [switch]$IsLast
    )
    
    if ([string]::IsNullOrWhiteSpace($Content)) {
        return ""
    }
    
    $output = ""
    
    # Add prefix icon if specified
    if ($Block.icon) {
        $icon = if ($Block.icon.StartsWith('nerd:')) {
            Get-NerdFontIcon -Type $Block.icon.Substring(5)
        } else {
            $Block.icon
        }
        $Content = "$icon $Content"
    }
    
    # Add padding
    $paddedContent = " $Content "
    
    # Create the block with background and foreground colors using Write-Host directly
    Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline
    
    # Add separator if not the last block
    if (-not $IsLast -and $Block.separator) {
        $separatorSymbol = if ($Block.separator.StartsWith('powerline:')) {
            Get-PowerlineSymbol -Type $Block.separator.Substring(10)
        } elseif ($Block.separator) {
            $Block.separator
        } else {
            ""
        }
        
        if ($separatorSymbol) {
            Write-Host $separatorSymbol -NoNewline
        }
    }
    
    return ""  # Return empty since we're writing directly to host
}

function Render-Prompt {
    param([string]$ThemeName = $script:PSThemeConfig.CurrentTheme)
    
    $themeConfig = Get-ThemeConfig -ThemeName $ThemeName
    if (-not $themeConfig) {
        return "PS> "
    }
    
    $blocks = $themeConfig.blocks
    
    # Render blocks directly to console
    for ($i = 0; $i -lt $blocks.Count; $i++) {
        $block = $blocks[$i]
        $isLast = ($i -eq ($blocks.Count - 1))
        
        # Skip disabled blocks
        if ($block.enabled -eq $false) {
            continue
        }
        
        # Get content from the appropriate module
        $content = Invoke-BlockModule -BlockName $block.type -BlockConfig $block -ThemeConfig $themeConfig
        
        if ($content) {
            Render-Block -Block $block -ThemeConfig $themeConfig -Content $content -IsLast $isLast | Out-Null
        }
    }
    
    # Add final prompt symbol if specified in theme
    if ($themeConfig.prompt_symbol) {
        $symbolType = if ($themeConfig.prompt_symbol.StartsWith('symbol:')) {
            $themeConfig.prompt_symbol.Substring(7)
        } else {
            'chevron'
        }
        
        $symbol = Get-PromptSymbol -Type $symbolType
        $symbolColor = if ($themeConfig.prompt_symbol_color) { $themeConfig.prompt_symbol_color } else { 'white' }
        
        Write-ColoredText -Text " $symbol " -ForegroundColor $symbolColor -NoNewline
    }
    else {
        Write-Host " " -NoNewline
    }
    
    return ""  # Return empty string since we write directly to console
}

function Set-CurrentTheme {
    param([string]$ThemeName)
    
    $themePath = Join-Path $script:PSThemeConfig.ThemesPath "$ThemeName.json"
    
    if (Test-Path $themePath) {
        $script:PSThemeConfig.CurrentTheme = $ThemeName
        Write-Host "Theme changed to: $ThemeName" -ForegroundColor Green
        return $true
    }
    else {
        Write-Error "Theme '$ThemeName' not found."
        return $false
    }
}

# Functions are available globally when dot-sourced