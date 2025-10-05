# PowerShell Theme Framework - Utility Functions
# Collection of helper functions for colors, separators, and formatting

# Global configuration
$script:PSThemeConfig = @{
    CurrentTheme = "default"
    ThemesPath = Join-Path $PSScriptRoot "..\themes"
    ModulesPath = Join-Path $PSScriptRoot "..\modules"
    SupportsAnsi = $false  # Temporarily disabled to use fallback colors
}

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
        '#ffffff' = 'White'
        '#000000' = 'Black'
        '#0078d4' = 'Blue'
        '#106ebe' = 'DarkBlue'
        '#2d5016' = 'DarkGreen'
        '#f14c4c' = 'Red'
        '#00ffff' = 'Cyan'
        '#ff00ff' = 'Magenta'
        '#ffff00' = 'Yellow'
        '#00ff00' = 'Green'
        '#ff0080' = 'Magenta'
        '#8000ff' = 'DarkMagenta'
        'white' = 'White'
        'black' = 'Black'
        'red' = 'Red'
        'green' = 'Green'
        'blue' = 'Blue'
        'yellow' = 'Yellow'
        'cyan' = 'Cyan'
        'magenta' = 'Magenta'
    }
    
    $fgColor = if ($colorMap.ContainsKey($ForegroundColor.ToLower())) { 
        $colorMap[$ForegroundColor.ToLower()] 
    } else { 
        'White' 
    }
    
    $bgColor = if ($BackgroundColor -and $colorMap.ContainsKey($BackgroundColor.ToLower())) { 
        $colorMap[$BackgroundColor.ToLower()] 
    } else { 
        $null 
    }
    
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

function Get-PowerlineSymbol {
    param(
        [ValidateSet('right-arrow', 'left-arrow', 'right-thin', 'left-thin', 'separator')]
        [string]$Type
    )
    
    $symbols = @{
        'right-arrow' = '>'
        'left-arrow' = '<'
        'right-thin' = '|'
        'left-thin' = '|'
        'separator' = '|'
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
        [ValidateSet('arrow', 'lambda', 'chevron', 'triangle')]
        [string]$Type = 'chevron'
    )
    
    $symbols = @{
        'arrow' = '->'
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
    
    $parts = $Path -split [IO.Path]::DirectorySeparatorChar
    if ($parts.Count -le 3) {
        return $Path
    }
    
    $first = $parts[0]
    $last = $parts[-1]
    $middle = $parts[1..($parts.Count-2)]
    
    $compressed = "$first\...\$last"
    
    if ($compressed.Length -le $MaxLength) {
        return $compressed
    }
    
    return "...\$last"
}

# Functions and variables are available globally when dot-sourced