# Retro Neon Theme - Colors
# Theme-specific color definitions and functions

# Theme-specific color palette
$RetroNeonColors = @{
    'primary' = 'Cyan'
    'secondary' = 'Magenta'
    'accent' = 'Yellow'
    'text' = 'White'
}

# Color functions specific to retro-neon theme
function Write-RetroNeonColoredText {
    param(
        [string]$Text,
        [string]$ForegroundColor = 'White',
        [string]$BackgroundColor = $null,
        [switch]$NoNewline
    )
    
    # Use main framework's Write-ColoredText for now
    Write-ColoredText -Text $Text -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline:$NoNewline
}

# Any other retro-neon specific color functions can be added here