# Minimal Theme - Colors
# Theme-specific color definitions and functions

# Theme-specific color palette
$MinimalColors = @{
    'primary' = 'Gray'
    'secondary' = 'DarkGray'
    'accent' = 'White'
    'text' = 'Gray'
}

# Color functions specific to minimal theme
function Write-MinimalColoredText {
    param(
        [string]$Text,
        [string]$ForegroundColor = 'Gray',
        [string]$BackgroundColor = $null,
        [switch]$NoNewline
    )
    
    # Use main framework's Write-ColoredText for now
    Write-ColoredText -Text $Text -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline:$NoNewline
}

# Any other minimal specific color functions can be added here