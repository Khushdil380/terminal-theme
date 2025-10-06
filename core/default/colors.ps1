# Default Theme - Colors
# Theme-specific color definitions and functions

# Theme-specific color palette
$DefaultColors = @{
    'primary' = 'Blue'
    'secondary' = 'Gray'
    'accent' = 'White'
    'text' = 'White'
}

# Color functions specific to default theme
function Write-DefaultColoredText {
    param(
        [string]$Text,
        [string]$ForegroundColor = 'White',
        [string]$BackgroundColor = $null,
        [switch]$NoNewline
    )
    
    # Use main framework's Write-ColoredText for now
    Write-ColoredText -Text $Text -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline:$NoNewline
}

# Any other default specific color functions can be added here