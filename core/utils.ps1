# PowerShell Theme Framework - Utility Functions
# Collection of helper functions for colors, separators, and formatting

# Global configuration
$global:PSThemeConfig = @{
    CurrentTheme = "default"
    ThemesPath = Join-Path $PSScriptRoot "..\themes"
    ModulesPath = Join-Path $PSScriptRoot "..\modules"
    ConfigPath = Join-Path $PSScriptRoot "..\config"
    SupportsAnsi = $false  # Temporarily disabled to use fallback colors
}

# Create config directory if it doesn't exist
if (-not (Test-Path $global:PSThemeConfig.ConfigPath)) {
    New-Item -ItemType Directory -Path $global:PSThemeConfig.ConfigPath -Force | Out-Null
}

# Load saved theme on startup
function Get-SavedTheme {
    $configFile = Join-Path $global:PSThemeConfig.ConfigPath "current-theme.txt"
    if (Test-Path $configFile) {
        $savedTheme = Get-Content $configFile -Raw | ForEach-Object { $_.Trim() }
        if ($savedTheme -and (Test-Path (Join-Path $global:PSThemeConfig.ThemesPath "$savedTheme.json"))) {
            return $savedTheme
        }
    }
    return "default"
}

# Save current theme to persistent storage
function Save-CurrentTheme {
    param([string]$ThemeName)
    
    $configFile = Join-Path $global:PSThemeConfig.ConfigPath "current-theme.txt"
    try {
        $ThemeName | Out-File -FilePath $configFile -Encoding UTF8 -NoNewline
        return $true
    }
    catch {
        Write-Warning "Failed to save theme preference: $_"
        return $false
    }
}

# Initialize with saved theme
$global:PSThemeConfig.CurrentTheme = Get-SavedTheme

# Color utility functions
function ConvertTo-AnsiColor {
    param(
        [string]$Color,
        [switch]$Background
    )
    
    $colorMap = @{
        'black' = '30'
        'red' = '31'
        'green' = '32'
        'yellow' = '33'
        'blue' = '34'
        'magenta' = '35'
        'cyan' = '36'
        'white' = '37'
        'bright-black' = '90'
        'bright-red' = '91'
        'bright-green' = '92'
        'bright-yellow' = '93'
        'bright-blue' = '94'
        'bright-magenta' = '95'
        'bright-cyan' = '96'
        'bright-white' = '97'
    }
    
    if ($Background) {
        $offset = 10
    } else {
        $offset = 0
    }
    
    # Handle hex colors
    if ($Color -match '^#([0-9A-Fa-f]{6})$') {
        $hex = $Color.Substring(1)
        $r = [Convert]::ToInt32($hex.Substring(0,2), 16)
        $g = [Convert]::ToInt32($hex.Substring(2,2), 16)
        $b = [Convert]::ToInt32($hex.Substring(4,2), 16)
        
        if ($Background) {
            return "48;2;$r;$g;$b"
        } else {
            return "38;2;$r;$g;$b"
        }
    }
    
    # Handle named colors
    if ($colorMap.ContainsKey($Color.ToLower())) {
        $colorCode = [int]$colorMap[$Color.ToLower()] + $offset
        return $colorCode
    }
    
    # Default to white
    return if ($Background) { '47' } else { '37' }
}

function Write-ColoredText {
    param(
        [string]$Text,
        [string]$ForegroundColor = "white",
        [string]$BackgroundColor = $null,
        [switch]$NoNewline
    )
    
    # Map colors to PowerShell console colors
    $colorMap = @{
        # Basic colors
        '#ffffff' = 'White'
        '#000000' = 'Black'
        'white' = 'White'
        'black' = 'Black'
        'red' = 'Red'
        'green' = 'Green'
        'blue' = 'Blue'
        'yellow' = 'Yellow'
        'cyan' = 'Cyan'
        'magenta' = 'Magenta'
        
        # Default theme colors
        '#0078d4' = 'Blue'
        '#106ebe' = 'DarkBlue'
        '#2d5016' = 'DarkGreen'
        '#f14c4c' = 'Red'
        
        # Retro neon theme colors
        '#00ffff' = 'Cyan'
        '#ff00ff' = 'Magenta'
        '#ffff00' = 'Yellow'
        '#00ff00' = 'Green'
        '#ff0080' = 'Magenta'
        '#8000ff' = 'DarkMagenta'
        
        # Gradient modern theme colors
        '#6366f1' = 'DarkBlue'
        '#8b5cf6' = 'DarkMagenta'
        '#a855f7' = 'Magenta'
        '#c084fc' = 'DarkMagenta'
        '#ddd6fe' = 'Gray'
        
        # Minimal theme colors
        '#404040' = 'DarkGray'
        '#008000' = 'DarkGreen'
        
    # ...existing code...
        
        # Additional color mappings
        '#dc3545' = 'Red'
        '#28a745' = 'Green'
        '#ffc107' = 'Yellow'
        '#17a2b8' = 'Cyan'
        '#6f42c1' = 'DarkMagenta'
        '#e83e8c' = 'Magenta'
        '#fd7e14' = 'DarkYellow'
        '#20c997' = 'DarkCyan'
        '#6c757d' = 'DarkGray'
    }
    
    $fgColor = if ($colorMap.ContainsKey($ForegroundColor.ToLower())) { 
        $colorMap[$ForegroundColor.ToLower()] 
    } else { 
        'White' 
    }
    
    $bgColor = if ($BackgroundColor -and $BackgroundColor -ne "" -and $colorMap.ContainsKey($BackgroundColor.ToLower())) { 
        $colorMap[$BackgroundColor.ToLower()] 
    } else { 
        $null 
    }
    
    # Debug output disabled
    
    try {
        if ($BackgroundColor -and $bgColor) {
            if ($NoNewline) {
                Write-Host $Text -ForegroundColor $fgColor -BackgroundColor $bgColor -NoNewline
            } else {
                Write-Host $Text -ForegroundColor $fgColor -BackgroundColor $bgColor
            }
        } else {
            if ($NoNewline) {
                Write-Host $Text -ForegroundColor $fgColor -NoNewline
            } else {  
                Write-Host $Text -ForegroundColor $fgColor
            }
        }
    }
    catch {
        # Fallback if colors don't work
        if ($NoNewline) {
            Write-Host $Text -NoNewline
        } else {
            Write-Host $Text
        }
    }
}

function Get-PowerlineSymbol {
    param(
        [ValidateSet('right-arrow', 'left-arrow', 'right-thin', 'left-thin', 'separator')]
        [string]$Type
    )
    # Use clean, reliable arrow symbols that work across terminals
    $symbols = @{
        'right-arrow' = [char]0x25B6  # ▶ Black right-pointing triangle
        'left-arrow' = [char]0x25C0   # ◀ Black left-pointing triangle  
        'right-thin' = [char]0x276F   # ❯ Heavy right-pointing angle quotation mark
        'left-thin' = [char]0x276E    # ❮ Heavy left-pointing angle quotation mark
        'separator' = [char]0x2502     # │ Box drawings light vertical
    }
    return $symbols[$Type]
}

function Get-NerdFontIcon {
    param(
        [ValidateSet('folder', 'folder-open', 'home', 'git-branch', 'git-commit', 'user', 'computer', 'clock', 'terminal', 'code', 'star')]
        [string]$Type
    )
    
    $icons = @{
        'folder' = '[DIR]'
        'folder-open' = '[DIR]'
        'home' = '[HOME]'
        'git-branch' = '[GIT]'
        'git-commit' = '[COMMIT]'
        'user' = '[USER]'
        'computer' = '[PC]'
        'clock' = '[TIME]'
        'terminal' = '[TERM]'
        'code' = '[CODE]'
        'star' = '*'
    }
    
    return $icons[$Type]
}

function Get-PromptSymbol {
    param(
        [ValidateSet('lambda', 'chevron', 'triangle')]
        [string]$Type = 'chevron'
    )
    $symbols = @{
        'lambda' = 'L'
        'chevron' = '>'
        'triangle' = '>'
    }
    
    return $symbols[$Type]
}

function Test-GitRepository {
    try {
        $gitStatus = git rev-parse --is-inside-work-tree 2>$null
        return $gitStatus -eq 'true'
    }
    catch {
        return $false
    }
}

function Get-GitBranchName {
    if (-not (Test-GitRepository)) {
        return $null
    }
    
    try {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        return $branch
    }
    catch {
        return $null
    }
}

function Get-GitStatus {
    if (-not (Test-GitRepository)) {
        return @{
            HasChanges = $false
            HasStaged = $false
            HasUntracked = $false
        }
    }
    
    try {
        $status = git status --porcelain 2>$null
        $hasChanges = $status.Count -gt 0
        $hasStaged = ($status | Where-Object { $_ -match '^[MADRC]' }).Count -gt 0
        $hasUntracked = ($status | Where-Object { $_.StartsWith('??') }).Count -gt 0
        
        return @{
            HasChanges = $hasChanges
            HasStaged = $hasStaged
            HasUntracked = $hasUntracked
        }
    }
    catch {
        return @{
            HasChanges = $false
            HasStaged = $false
            HasUntracked = $false
        }
    }
}

function Compress-Path {
    param(
        [string]$Path,
        [int]$MaxLength = 50
    )
    
    if ($Path.Length -le $MaxLength) {
        return $Path
    }
    
    # Use consistent separator
    $separator = [IO.Path]::DirectorySeparatorChar
    $parts = $Path -split [regex]::Escape($separator)
    
    if ($parts.Count -le 3) {
        return $Path
    }
    
    $first = $parts[0]
    $last = $parts[-1]
    
    $compressed = "$first$separator...$separator$last"
    
    if ($compressed.Length -le $MaxLength) {
        return $compressed
    }
    
    return "...$separator$last"
}

# Functions and variables are available globally when dot-sourced