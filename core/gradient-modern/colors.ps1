# Gradient Modern Theme - Colors
# Theme-specific color definitions and functions

# Theme-specific color palette - CUSTOMIZABLE
$GradientModernColors = @{
    'primary' = 'Magenta'      # 🎨 Change this to any color
    'secondary' = 'Cyan'       # 🎨 Background colors
    'accent' = 'Blue'          # 🎨 Highlight colors  
    'text' = 'White'           # 🎨 Text colors
    'custom' = 'Green'         # 🎨 Add your own colors
    'command' = 'Yellow'       # 🎨 NEW: Command text color
    'error' = 'Red'            # 🎨 NEW: Error color
    'success' = 'Green'        # 🎨 NEW: Success color
}

# Custom function only for gradient-modern theme
function Write-GradientModernCustomText {
    param([string]$Text)
    Write-Host $Text -ForegroundColor $GradientModernColors.custom -NoNewline
}

# Color functions specific to gradient-modern theme
function Write-GradientModernColoredText {
    param(
        [string]$Text,
        [string]$ForegroundColor = 'White',
        [string]$BackgroundColor = $null,
        [switch]$NoNewline
    )
    
    # Use main framework's Write-ColoredText for now
    Write-ColoredText -Text $Text -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline:$NoNewline
}

# Any other gradient-modern specific color functions can be added here