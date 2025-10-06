# Arrows Modern Theme - Colors
# Theme-specific color definitions and functions

# Theme-specific color palette
$ArrowsModernColors = @{
    'primary' = 'Blue'
    'secondary' = 'Green'
    'accent' = 'Cyan'
    'text' = 'White'
}

# Color functions specific to arrows-modern theme
function Write-ArrowsModernColoredText {
    param(
        [string]$Text,
        [string]$ForegroundColor = 'White',
        [string]$BackgroundColor = $null,
        [switch]$NoNewline
    )
    
    # Use main framework's Write-ColoredText for now
    Write-ColoredText -Text $Text -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline:$NoNewline
}

# Any other arrows-modern specific color functions can be added here