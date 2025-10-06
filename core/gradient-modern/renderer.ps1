# Gradient Modern Theme - Renderer
# Moved from main renderer.ps1 - working functionality preserved

function Render-GradientModernPrompt {
    param([object]$ThemeConfig)
    
    if (-not $ThemeConfig) {
        return "PS> "
    }
    
    $blocks = $ThemeConfig.blocks
    
    # Filter enabled blocks first
    $enabledBlocks = $blocks | Where-Object { $_.enabled -ne $false }
    
    # Render blocks with proper powerline logic (same as main renderer)
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
