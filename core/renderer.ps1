# PowerShell Theme Framework - Renderer
# Handles rendering blocks based on theme configuration

# Import utilities
. "$PSScriptRoot\utils.ps1"

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

function Invoke-BlockModule {
    param(
        [string]$BlockName,
        [object]$BlockConfig,
        [object]$ThemeConfig
    )
    
    $modulePath = Join-Path $global:PSThemeConfig.ModulesPath "$BlockName.ps1"
    
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
        [bool]$IsLast = $false,
        [bool]$IsFirst = $false,
        [object]$NextBlock = $null
    )
    
    if ([string]::IsNullOrWhiteSpace($Content)) {
        return ""
    }
    
    # Handle icon if specified
    if ($Block.icon) {
        $icon = if ($Block.icon.StartsWith('nerd:')) {
            Get-NerdFontIcon -Type $Block.icon.Substring(5)
        } elseif ($Block.icon.StartsWith('\u')) {
            # Handle Unicode escapes like \uF007
            try {
                [char][int]($Block.icon.Substring(2), 16)
            } catch {
                $Block.icon # Fallback to original text
            }
        } else {
            $Block.icon
        }
        $Content = "$icon $Content"
    }
    
    # Check if this is a powerline style theme
    $isPowerlineStyle = ($ThemeConfig.style -eq "powerline" -or ($Block.separator -and $Block.separator.StartsWith('powerline:')))
    
    if ($isPowerlineStyle) {
        # Powerline style rendering
        
        # Leading diamond for first block
        if ($IsFirst -and ($Block.leading_diamond -or $ThemeConfig.leading_diamond)) {
            $diamond = if ($Block.leading_diamond) { $Block.leading_diamond } else { $ThemeConfig.leading_diamond }
            try {
                $diamondChar = if ($diamond.StartsWith('\u')) { [char][int]($diamond.Substring(2), 16) } else { $diamond }
                Write-ColoredText -Text $diamondChar -ForegroundColor $Block.background -NoNewline
            } catch {
                # Fallback diamond
                Write-Host "◆" -ForegroundColor $Block.background -NoNewline
            }
        }
        
        # Block content with background
        $paddedContent = " $Content "
        Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline
        
        # Powerline arrow separator
        if (-not $IsLast -and $NextBlock) {
            # Use true powerline symbol with color inversion for seamless transition
            $arrowSymbol = Get-PowerlineSymbolWithFallback -Primary 'powerline-right' -Fallback 'right-arrow'
            
            # Current block background becomes arrow foreground, next block background becomes arrow background
            Write-ColoredText -Text $arrowSymbol -ForegroundColor $Block.background -BackgroundColor $NextBlock.background -NoNewline
        }
        elseif ($IsLast) {
            # Trailing diamond or arrow for last block
            if ($Block.trailing_diamond -or $ThemeConfig.trailing_diamond) {
                $diamond = if ($Block.trailing_diamond) { $Block.trailing_diamond } else { $ThemeConfig.trailing_diamond }
                try {
                    $diamondChar = if ($diamond.StartsWith('\u')) { [char][int]($diamond.Substring(2), 16) } else { $diamond }
                    Write-ColoredText -Text $diamondChar -ForegroundColor $Block.background -NoNewline
                } catch {
                    # Fallback diamond
                    Write-Host "◆" -ForegroundColor $Block.background -NoNewline
                }
            } else {
                # Simple arrow termination
                $arrowSymbol = Get-PowerlineSymbolWithFallback -Primary 'powerline-right' -Fallback 'right-arrow'
                Write-ColoredText -Text $arrowSymbol -ForegroundColor $Block.background -NoNewline
            }
        }
    } else {
        # Standard rendering for non-powerline themes
        $paddedContent = " $Content "
        Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline
    }
    
    return ""  # Return empty since we're writing directly to host
}

function Render-Prompt {
    param([string]$ThemeName = $global:PSThemeConfig.CurrentTheme)
    
    $themeConfig = Get-ThemeConfig -ThemeName $ThemeName
    if (-not $themeConfig) {
        return "PS> "
    }
    
    $blocks = $themeConfig.blocks
    
    # Filter enabled blocks first
    $enabledBlocks = $blocks | Where-Object { $_.enabled -ne $false }
    
    # Render blocks with proper powerline logic
    for ($i = 0; $i -lt $enabledBlocks.Count; $i++) {
        $block = $enabledBlocks[$i]
        $isLast = ($i -eq ($enabledBlocks.Count - 1))
        $isFirst = ($i -eq 0)
        $nextBlock = if (-not $isLast) { $enabledBlocks[$i + 1] } else { $null }
        
        # Get content from the appropriate module
        $content = Invoke-BlockModule -BlockName $block.type -BlockConfig $block -ThemeConfig $themeConfig
        
        if ($content) {
            # Render the block with all powerline parameters
            Render-Block -Block $block -ThemeConfig $themeConfig -Content $content -IsLast $isLast -IsFirst $isFirst -NextBlock $nextBlock | Out-Null
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
