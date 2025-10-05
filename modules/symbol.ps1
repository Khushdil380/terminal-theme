# Symbol Block Module
# Displays custom symbols or status indicators

# Import utilities
. "$PSScriptRoot\..\core\utils.ps1"

function Get-SymbolBlock {
    param(
        [object]$Config,
        [object]$ThemeConfig
    )
    
    try {
        # Determine symbol based on configuration
        $symbol = ""
        
        if ($Config.type) {
            switch ($Config.type) {
                "admin" {
                    # Check if running as administrator
                    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
                    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
                    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
                    
                    $symbol = if ($isAdmin) { 
                        if ($Config.admin_symbol) { $Config.admin_symbol } else { "#" }
                    } else { 
                        if ($Config.user_symbol) { $Config.user_symbol } else { "$" }
                    }
                }
                "exit_code" {
                    # Show symbol based on last exit code
                    $lastExitCode = $LASTEXITCODE
                    if ($lastExitCode -eq 0 -or $null -eq $lastExitCode) {
                        $symbol = if ($Config.success_symbol) { $Config.success_symbol } else { "✓" }
                    } else {
                        $symbol = if ($Config.error_symbol) { $Config.error_symbol } else { "✗" }
                    }
                }
                "custom" {
                    # Use custom symbol
                    $symbol = if ($Config.symbol) { $Config.symbol } else { "◆" }
                }
                "nerd_font" {
                    # Use nerd font icon
                    if ($Config.icon_name) {
                        $symbol = Get-NerdFontIcon -Type $Config.icon_name
                    } else {
                        $symbol = Get-NerdFontIcon -Type "star"
                    }
                }
                default {
                    $symbol = "❯"
                }
            }
        }
        else {
            # Default symbol
            $symbol = if ($Config.symbol) { $Config.symbol } else { "❯" }
        }
        
        # Apply template if specified
        if ($Config.template) {
            $content = $Config.template -replace '{{symbol}}', $symbol
        }
        else {
            $content = $symbol
        }
        
        return $content
    }
    catch {
        Write-Warning "Failed to get symbol: $_"
        return $null
    }
}

# Function is available globally when dot-sourced