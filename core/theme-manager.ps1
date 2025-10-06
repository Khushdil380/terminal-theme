# PowerShell Theme Framework - Central Theme Manager
# Manages loading and calling theme-specific files

function Get-ThemeConfig {
    param([string]$ThemeName = $global:PSThemeConfig.CurrentTheme)
    
    $themePath = Join-Path $global:PSThemeConfig.ThemesPath "$ThemeName.json"
    
    if (-not (Test-Path $themePath)) {
        Write-Warning "Theme '$ThemeName' not found. Using default theme."
        $themePath = Join-Path $global:PSThemeConfig.ThemesPath "default.json"
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

# Rendering functions now moved to individual theme utils.ps1 files for true modularity

function Invoke-ThemeRenderer {
    param([string]$ThemeName = $global:PSThemeConfig.CurrentTheme)
    
    # Get theme configuration
    $themeConfig = Get-ThemeConfig -ThemeName $ThemeName
    if (-not $themeConfig) {
        return "PS> "
    }
    
    # Define theme paths
    $themeDir = Join-Path $PSScriptRoot $ThemeName
    $rendererPath = Join-Path $themeDir "renderer.ps1"
    $colorsPath = Join-Path $themeDir "colors.ps1"
    $utilsPath = Join-Path $themeDir "utils.ps1"
    
    # Check if theme folder exists
    if (-not (Test-Path $themeDir)) {
        Write-Warning "Theme folder not found: $themeDir. Using fallback rendering."
        return Render-FallbackPrompt -ThemeConfig $themeConfig
    }
    
    try {
        # Load theme-specific files
        if (Test-Path $colorsPath) {
            . $colorsPath
        }
        
        if (Test-Path $utilsPath) {
            . $utilsPath
        }
        
        if (Test-Path $rendererPath) {
            . $rendererPath
            
            # Call theme-specific render function
            $renderFunction = "Render-" + (Get-Culture).TextInfo.ToTitleCase($ThemeName.Replace('-', '')) + "Prompt"
            
            if (Get-Command $renderFunction -ErrorAction SilentlyContinue) {
                & $renderFunction -ThemeConfig $themeConfig
                return ""
            } else {
                Write-Warning "Render function '$renderFunction' not found in $rendererPath"
            }
        } else {
            Write-Warning "Renderer file not found: $rendererPath"
        }
    }
    catch {
        Write-Warning "Error loading theme '$ThemeName': $_"
    }
    
    # Fallback to default rendering if theme-specific loading fails
    return Render-FallbackPrompt -ThemeConfig $themeConfig
}

# Fallback renderer (same as original main renderer logic)
function Render-FallbackPrompt {
    param([object]$ThemeConfig)
    
    if (-not $ThemeConfig) {
        return "PS> "
    }
    
    $blocks = $ThemeConfig.blocks
    
    # Filter enabled blocks first
    $enabledBlocks = $blocks | Where-Object { $_.enabled -ne $false }
    
    # Render blocks with proper powerline logic (same as original)
    for ($i = 0; $i -lt $enabledBlocks.Count; $i++) {
        $block = $enabledBlocks[$i]
        $isLast = ($i -eq ($enabledBlocks.Count - 1))
        $isFirst = ($i -eq 0)
        $nextBlock = if (-not $isLast) { $enabledBlocks[$i + 1] } else { $null }
        
        # Get content from the appropriate module
        $content = Invoke-BlockModule -BlockName $block.type -BlockConfig $block -ThemeConfig $ThemeConfig
        
        if ($content) {
            # Render the block with all powerline parameters
            Render-Block -Block $block -ThemeConfig $ThemeConfig -Content $content -IsLast $isLast -IsFirst $isFirst -NextBlock $nextBlock | Out-Null
        }
    }
    
    # Add final prompt symbol if specified in theme
    if ($ThemeConfig.prompt_symbol) {
        $symbolType = if ($ThemeConfig.prompt_symbol.StartsWith('symbol:')) {
            $ThemeConfig.prompt_symbol.Substring(7)
        } else {
            'chevron'
        }
        
        $symbol = Get-PromptSymbol -Type $symbolType
        $symbolColor = if ($ThemeConfig.prompt_symbol_color) { $ThemeConfig.prompt_symbol_color } else { 'white' }
        
        Write-ColoredText -Text " $symbol " -ForegroundColor $symbolColor -NoNewline
    }
    else {
        Write-Host " " -NoNewline
    }
    
    return ""  # Return empty string since we write directly to console
}