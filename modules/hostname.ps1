# Hostname Block Module
# Displays the computer name/hostname

function Get-HostnameBlock {
    param(
        [object]$Config,
        [object]$ThemeConfig
    )
    
    try {
        # Get computer name
        $hostname = $env:COMPUTERNAME
        
        if ([string]::IsNullOrWhiteSpace($hostname)) {
            $hostname = [System.Environment]::MachineName
        }
        
        # Apply template if specified
        if ($Config.template) {
            $content = $Config.template -replace '{{hostname}}', $hostname
        }
        else {
            $content = $hostname
        }
        
        return $content
    }
    catch {
        Write-Warning "Failed to get hostname: $_"
        return $null
    }
}

# Function is available globally when dot-sourced