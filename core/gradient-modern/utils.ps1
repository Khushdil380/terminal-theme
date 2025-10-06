# Gradient Modern Theme - Utilities
# Theme-specific helper functions

# Theme-specific color utilities for gradient-modern
function Get-GradientModernColor {
    param([string]$ColorName)
    
    # Add any gradient-modern specific color handling here
    return $ColorName
}

# Theme-specific separator utilities
function Get-GradientModernSeparator {
    param([string]$Type = 'default')
    
    # Add any gradient-modern specific separator logic here
    return ' '
}

# Theme-specific block module execution (independent from core)
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

# Theme-specific block rendering (independent from core)
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
        
        # Block content with background - CUSTOMIZABLE SPACING
        $paddedContent = "  $Content  "  # 🎨 CHANGED: Double spaces for more padding
        Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline
        
        # Powerline arrow separator - CUSTOMIZABLE
        if (-not $IsLast -and $NextBlock) {
            # Use true powerline symbol with color inversion for seamless transition
            $arrowSymbol = Get-PowerlineSymbolWithFallback -Primary 'powerline-right' -Fallback 'right-arrow'
            
            # Current block background becomes arrow foreground, next block background becomes arrow background
            Write-ColoredText -Text $arrowSymbol -ForegroundColor $Block.background -BackgroundColor $NextBlock.background -NoNewline
            
            # 🎨 NEW: Add custom spacing after arrow (only for gradient-modern theme)
            Write-Host " " -NoNewline  # Extra space between blocks
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
                # End powerline with simple arrow
                $arrowSymbol = Get-PowerlineSymbolWithFallback -Primary 'powerline-right' -Fallback 'right-arrow'
                Write-ColoredText -Text $arrowSymbol -ForegroundColor $Block.background -NoNewline
            }
        }
    }
    else {
        # Standard rendering for non-powerline themes - CUSTOMIZABLE
        $paddedContent = "[ $Content ]"  # 🎨 CHANGED: Custom brackets instead of plain spaces
        Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline
        
        # 🎨 NEW: Add separator between non-powerline blocks
        if (-not $IsLast) {
            Write-Host " | " -ForegroundColor $GradientModernColors.accent -NoNewline  # Custom separator
        }
    }
    
    return ""  # Return empty since we're writing directly to host
}

# Any other gradient-modern specific utilities can be added here