# Usage Guide - PowerShell Theme Framework

This guide covers all aspects of using the PowerShell Theme Framework, from basic installation to advanced customization.

## 📦 Installation

### Prerequisites

Before installing, ensure you have:

1. **PowerShell 5.1+** or **PowerShell Core 6.0+**
2. **Nerd Font** installed (recommended: MonaspiceXe Nerd Font Mono)
3. **Terminal with ANSI support** (Windows Terminal, VS Code, ConEmu, etc.)
4. **Git** (optional, for git branch display)

### Basic Installation

1. **Download or clone** the PowerShell-Themes repository
2. **Open PowerShell as Administrator** (if needed for profile access)
3. **Navigate** to the PowerShell-Themes directory
4. **Run the installer**:
   ```powershell
   .\scripts\install.ps1
   ```

### Installation Options

```powershell
# Install with default theme
.\scripts\install.ps1

# Install with specific theme
.\scripts\install.ps1 -ThemeName retro-neon

# Force reinstall (overwrites existing installation)
.\scripts\install.ps1 -Force

# Install with minimal theme
.\scripts\install.ps1 -ThemeName minimal
```

### Verification

After installation, verify everything works:

```powershell
# Restart PowerShell or reload profile
. $PROFILE

# Test the installation
Test-PSThemeSetup

# List available themes
Get-PSThemes

# Check current theme info
Get-PSThemeInfo
```

## 🎨 Theme Management

### Switching Themes

#### Method 1: PowerShell Commands (Session Only)
```powershell
# Change theme for current session
Set-PSTheme retro-neon
Set-PSTheme gradient-modern
Set-PSTheme minimal
```

#### Method 2: Change Theme Script (Session Only)
```powershell
# Change theme using script
.\scripts\change-theme.ps1 -Theme retro-neon

# List all available themes
.\scripts\change-theme.ps1 -List

# Preview a theme before applying
.\scripts\change-theme.ps1 -Theme gradient-modern -Preview
```

#### Method 3: Permanent Theme Change
```powershell
# Make theme change permanent (updates profile)
.\scripts\install.ps1 -ThemeName retro-neon -Force
```

### Theme Information

```powershell
# List all available themes
Get-PSThemes

# Get detailed info about current theme
Get-PSThemeInfo

# Preview theme configuration
.\scripts\change-theme.ps1 -Theme <theme-name> -Preview
```

## 🔧 Configuration and Customization

### Understanding Theme Structure

Each theme is defined in a JSON file with these main sections:

1. **Metadata**: Name, description, version
2. **Prompt Symbol**: The final prompt character
3. **Blocks**: Individual components of the prompt

### Block Configuration

Each block can have these properties:

```json
{
  "type": "username",           // Block type (username, directory, git-branch, etc.)
  "enabled": true,              // Whether to show this block
  "foreground": "#ffffff",      // Text color
  "background": "#0078d4",      // Background color
  "icon": "nerd:user",         // Icon to display
  "separator": "powerline:right-arrow",  // Separator style
  "separator_color": "#0078d4", // Separator color
  "template": "{{username}}"    // How to format the content
}
```

### Available Block Types

| Block Type | Description | Template Variables |
|------------|-------------|-------------------|
| `username` | Current user | `{{username}}` |
| `hostname` | Computer name | `{{hostname}}` |
| `directory` | Current path | `{{path}}` |
| `git-branch` | Git info | `{{branch}}`, `{{status}}` |
| `time` | Date/time | `{{time}}`, `{{date}}` |
| `symbol` | Custom symbols | `{{symbol}}` |

### Icon Options

#### Nerd Font Icons
```json
"icon": "nerd:user"        // 👤
"icon": "nerd:computer"    // 🖥
"icon": "nerd:folder"      // 📁
"icon": "nerd:git-branch"  // 
"icon": "nerd:clock"       // ⏰
```

#### Custom Unicode Icons
```json
"icon": "👤"    // User
"icon": "🏠"    // Home
"icon": "📁"    // Folder
"icon": "⏰"    // Clock
"icon": "★"     // Star
```

#### Powerline Separators
```json
"separator": "powerline:right-arrow"  // 
"separator": "powerline:left-arrow"   // 
"separator": "powerline:right-thin"   // 
"separator": "powerline:left-thin"    // 
```

### Color Formats

Colors can be specified in multiple formats:

```json
// Hex colors (preferred)
"foreground": "#ffffff"
"background": "#0078d4"

// Named colors
"foreground": "white"
"background": "blue"

// Bright colors
"foreground": "bright-green"
"background": "bright-black"
```

## 🛠 Advanced Usage

### Creating Theme Variants

You can create variations of existing themes by copying and modifying JSON files:

```powershell
# Copy existing theme
Copy-Item themes\default.json themes\my-theme.json

# Edit the new theme file
notepad themes\my-theme.json

# Apply your custom theme
Set-PSTheme my-theme
```

### Environment-Specific Themes

Create different themes for different environments:

```json
// themes/development.json - Development environment
{
  "name": "Development",
  "blocks": [
    {
      "type": "username",
      "background": "#00ff00",  // Green for dev
      // ... other settings
    }
  ]
}

// themes/production.json - Production environment
{
  "name": "Production",
  "blocks": [
    {
      "type": "username", 
      "background": "#ff0000",  // Red for production
      // ... other settings
    }
  ]
}
```

### Conditional Theme Loading

Add logic to your PowerShell profile to load themes based on conditions:

```powershell
# In your $PROFILE after the theme framework is loaded

# Load different themes based on computer name
if ($env:COMPUTERNAME -like "*DEV*") {
    Set-PSTheme development
} elseif ($env:COMPUTERNAME -like "*PROD*") {
    Set-PSTheme production
} else {
    Set-PSTheme default
}

# Or based on current directory
if ($PWD.Path -like "*\source\*") {
    Set-PSTheme development
}
```

## 🎯 Specific Use Cases

### Git-Heavy Workflows

For developers who work extensively with Git:

```json
{
  "blocks": [
    {
      "type": "directory",
      "max_length": 30,  // Shorter path for more git info
      // ...
    },
    {
      "type": "git-branch",
      "show_status": true,
      "staged_icon": "✓",
      "changes_icon": "●", 
      "untracked_icon": "?",
      "template": " {{branch}} {{status}}"
    }
  ]
}
```

### Server Administration

For system administrators:

```json
{
  "blocks": [
    {
      "type": "hostname",
      "foreground": "#ffffff",
      "background": "#dc3545",  // Red background for server awareness
      "template": "🖥 {{hostname}}"
    },
    {
      "type": "symbol",
      "type": "admin",          // Shows # for admin, $ for user
      "admin_symbol": "#",
      "user_symbol": "$"
    }
  ]
}
```

### Minimal Setup

For users who prefer minimal prompts:

```json
{
  "blocks": [
    {
      "type": "directory",
      "foreground": "#6b7280",
      "background": "",         // No background
      "separator": "",          // No separator
      "max_length": 50
    }
  ],
  "prompt_symbol": "symbol:arrow",
  "prompt_symbol_color": "#6b7280"
}
```

## 📊 Performance Considerations

### Optimizing Theme Performance

1. **Disable unused blocks**:
   ```json
   {
     "type": "time",
     "enabled": false  // Disable time block if not needed
   }
   ```

2. **Reduce git status checks** for large repositories:
   ```json
   {
     "type": "git-branch", 
     "show_status": false  // Skip git status for performance
   }
   ```

3. **Compress long paths**:
   ```json
   {
     "type": "directory",
     "max_length": 40  // Limit path length
   }
   ```

### Troubleshooting Performance

If your prompt feels slow:

```powershell
# Measure prompt rendering time
Measure-Command { prompt }

# Check which git repositories are slow
Measure-Command { git status --porcelain }

# Disable git status temporarily
Set-PSTheme minimal
```

## 🔄 Maintenance

### Updating Themes

```powershell
# Reload current theme after editing
.\scripts\apply-theme.ps1

# Or change to force reload
Set-PSTheme $currentTheme
```

### Backup and Restore

```powershell
# Your profile is automatically backed up during installation
# Backups are stored as: $PROFILE.backup.YYYYMMDD-HHMMSS

# List backups
Get-ChildItem "$PROFILE.backup.*"

# Restore from backup if needed
Copy-Item "$PROFILE.backup.20231205-143022" $PROFILE
```

### Cleaning Up

```powershell
# Uninstall theme framework
.\scripts\uninstall.ps1

# Keep backups when uninstalling
.\scripts\uninstall.ps1 -KeepBackup
```

## 🆘 Common Issues and Solutions

### Issue: Colors not displaying
**Solution**: 
- Ensure terminal supports ANSI colors
- Use Windows Terminal or VS Code terminal
- Check `$PSThemeConfig.SupportsAnsi`

### Issue: Icons showing as squares
**Solution**:
- Install Nerd Font (MonaspiceXe Nerd Font Mono recommended)
- Set terminal font to the Nerd Font
- Restart terminal after font installation

### Issue: Git information not showing
**Solution**:
- Ensure Git is installed and in PATH
- Navigate to a Git repository
- Check `git status` works in current directory

### Issue: Slow prompt
**Solution**:
- Disable unused blocks
- Set `show_status: false` for git blocks
- Use shorter `max_length` for directory blocks

### Issue: Theme not persisting
**Solution**:
- Use `.\scripts\install.ps1 -ThemeName <theme> -Force` for permanent changes
- Session-only changes use `Set-PSTheme <theme>`

## 📚 Next Steps

- Read [create-theme.md](create-theme.md) to learn how to create custom themes
- Explore the `modules/` directory to understand how blocks work
- Check the `themes/` directory for inspiration
- Join the community discussions for tips and tricks

---

For more advanced customization, see the [Custom Theme Creation Guide](create-theme.md).