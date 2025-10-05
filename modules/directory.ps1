# Directory Block Module
# Displays the current working directory

# Import utilities for path compression
. "$PSScriptRoot\..\core\utils.ps1"

function Get-DirectoryBlock {
    param(
        [object]$Config,
        [object]$ThemeConfig
    )
    
    try {
        # Get current location
        $currentPath = $PWD.Path
        
        # Handle home directory substitution
        $homeDir = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)
        if ($currentPath.StartsWith($homeDir)) {
            $currentPath = $currentPath.Replace($homeDir, "~")
        }
        
        # Apply path compression if max_length is specified
        if ($Config.max_length -and $Config.max_length -gt 0) {
            $currentPath = Compress-Path -Path $currentPath -MaxLength $Config.max_length
        }
        
        # Apply template if specified
        if ($Config.template) {
            $content = $Config.template -replace '{{path}}', $currentPath
        }
        else {
            $content = $currentPath
        }
        
        return $content
    }
    catch {
        Write-Warning "Failed to get directory: $_"
        return $null
    }
}

# Function is available globally when dot-sourced