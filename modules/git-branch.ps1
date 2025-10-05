# Git Branch Block Module
# Displays git branch information and status

# Import utilities for git functions
. "$PSScriptRoot\..\core\utils.ps1"

function Get-Git-BranchBlock {
    param(
        [object]$Config,
        [object]$ThemeConfig
    )
    
    try {
        # Check if we're in a git repository
        if (-not (Test-GitRepository)) {
            return $null
        }
        
        # Get branch name
        $branchName = Get-GitBranchName
        if ([string]::IsNullOrWhiteSpace($branchName)) {
            return $null
        }
        
        # Get git status
        $gitStatus = Get-GitStatus
        
        # Build status indicators
        $statusIndicators = ""
        
        if ($Config.show_status -eq $true) {
            if ($gitStatus.HasStaged) {
                $stagedIcon = if ($Config.staged_icon) { $Config.staged_icon } else { "+" }
                $statusIndicators += $stagedIcon
            }
            
            if ($gitStatus.HasChanges) {
                $changesIcon = if ($Config.changes_icon) { $Config.changes_icon } else { "!" }
                $statusIndicators += $changesIcon
            }
            
            if ($gitStatus.HasUntracked) {
                $untrackedIcon = if ($Config.untracked_icon) { $Config.untracked_icon } else { "?" }
                $statusIndicators += $untrackedIcon
            }
        }
        
        # Apply template if specified
        if ($Config.template) {
            $content = $Config.template -replace '{{branch}}', $branchName -replace '{{status}}', $statusIndicators
        }
        else {
            $content = if ($statusIndicators) { "$branchName $statusIndicators" } else { $branchName }
        }
        
        return $content
    }
    catch {
        Write-Warning "Failed to get git branch: $_"
        return $null
    }
}

# Function is available globally when dot-sourced