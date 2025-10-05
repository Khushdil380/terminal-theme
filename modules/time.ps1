# Time Block Module
# Displays current time

function Get-TimeBlock {
    param(
        [object]$Config,
        [object]$ThemeConfig
    )
    
    try {
        # Get current time
        $currentTime = Get-Date
        
        # Apply custom format if specified
        $timeFormat = if ($Config.format) { $Config.format } else { "HH:mm:ss" }
        
        $formattedTime = $currentTime.ToString($timeFormat)
        
        # Apply template if specified
        if ($Config.template) {
            $content = $Config.template -replace '{{time}}', $formattedTime -replace '{{date}}', $currentTime.ToString("yyyy-MM-dd")
        }
        else {
            $content = $formattedTime
        }
        
        return $content
    }
    catch {
        Write-Warning "Failed to get time: $_"
        return $null
    }
}

# Function is available globally when dot-sourced