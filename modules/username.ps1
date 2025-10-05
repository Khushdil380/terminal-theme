# Username Block Module
# Displays the current user name

function Get-UsernameBlock {
    param(
        [object]$Config,
        [object]$ThemeConfig
    )
    
    try {
        # Get current username
        $username = $env:USERNAME
        
        if ([string]::IsNullOrWhiteSpace($username)) {
            $username = [System.Environment]::UserName
        }
        
        # Apply template if specified
        if ($Config.template) {
            $content = $Config.template -replace '{{username}}', $username
        }
        else {
            $content = $username
        }
        
        return $content
    }
    catch {
        Write-Warning "Failed to get username: $_"
        return $null
    }
}

# Function is available globally when dot-sourced