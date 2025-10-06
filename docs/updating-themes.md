# 🔧 Updating Existing Themes

This guide shows you how to customize any existing theme in the PowerShell Theme Framework. Thanks to the **truly modular architecture**, you can modify any theme without affecting others.

## 🎯 **True Modularity Benefits**

- **✅ Complete Independence**: Each theme has its own rendering logic
- **✅ Zero Risk**: Modifications to one theme never affect others  
- **✅ Full Customization**: Change colors, spacing, separators, behavior
- **✅ Easy Rollback**: Restore original files if needed

## 📁 **Theme Structure**

Each theme has its own folder with three customizable files:

```
core/{theme-name}/
├── colors.ps1     # 🎨 Colors, palettes, custom color functions
├── utils.ps1      # 🔧 Rendering logic, spacing, separators 
└── renderer.ps1   # 🎭 Theme structure, blocks, layout
```

## 🎨 **1. Customizing Colors**

### **File**: `core/{theme-name}/colors.ps1`

#### **Basic Color Changes**
```powershell
# Example: Updating gradient-modern colors
$GradientModernColors = @{
    'primary' = 'Red'        # Change from Magenta to Red
    'secondary' = 'Yellow'   # Change background color  
    'accent' = 'Green'       # Change accent color
    'text' = 'White'         # Text color
    'command' = 'Cyan'       # Add new: Command text color
    'error' = 'Red'          # Add new: Error color
    'success' = 'Green'      # Add new: Success color
}
```

#### **Available PowerShell Colors**
```powershell
# Standard Colors
'Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 
'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 
'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White'

# Or use hex colors (converted automatically)
'#FF5733', '#33FF57', '#3357FF'
```

#### **Custom Color Functions**
```powershell
# Add theme-specific color functions
function Write-MyThemeColoredText {
    param([string]$Text, [string]$Color = 'White')
    Write-ColoredText -Text $Text -ForegroundColor $Color -NoNewline
}
```

## 🔧 **2. Customizing Spacing & Rendering**

### **File**: `core/{theme-name}/utils.ps1`

#### **Block Padding**
```powershell
# Find line ~105 in Render-Block function
# Default:
$paddedContent = " $Content "

# More padding:
$paddedContent = "  $Content  "

# Custom brackets:
$paddedContent = "[ $Content ]"

# Minimal padding:
$paddedContent = "$Content"
```

#### **Block Separators (Non-PowerLine Themes)**
```powershell
# Find the "else" block for non-powerline rendering
# Default:
$paddedContent = " $Content "
Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline

# Add custom separators:
$paddedContent = "[ $Content ]"
Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline

# Add separator between blocks:
if (-not $IsLast) {
    Write-Host " | " -ForegroundColor 'Cyan' -NoNewline
}
```

#### **PowerLine Arrow Customization**
```powershell
# Find the powerline arrow section (~line 110)
# Add spacing after arrows:
Write-ColoredText -Text $arrowSymbol -ForegroundColor $Block.background -BackgroundColor $NextBlock.background -NoNewline

# Add extra space after arrow (only for this theme):
Write-Host " " -NoNewline
```

#### **Icon Customization**
```powershell
# Modify icon handling in Render-Block function
if ($Block.icon) {
    $icon = if ($Block.icon.StartsWith('nerd:')) {
        Get-NerdFontIcon -Type $Block.icon.Substring(5)
    } elseif ($Block.icon.StartsWith('\\u')) {
        try {
            [char][int]($Block.icon.Substring(2), 16)
        } catch {
            $Block.icon
        }
    } else {
        $Block.icon
    }
    
    # Customize icon spacing:
    $Content = "$icon  $Content"  # Double space after icon
    # Or: $Content = "($icon) $Content"  # Wrap icon in parentheses
}
```

## 🎭 **3. Customizing Theme Structure**

### **File**: `core/{theme-name}/renderer.ps1`

#### **Changing Block Order**
```powershell
# The renderer uses the blocks defined in themes/{theme-name}.json
# But you can add conditional logic here:

function Render-MyThemePrompt {
    param([object]$ThemeConfig)
    
    # Add custom logic before standard rendering
    if ($env:COMPUTERNAME -eq 'WORKPC') {
        Write-Host "💼 " -NoNewline -ForegroundColor 'Yellow'
    }
    
    # Continue with standard rendering...
    $blocks = $ThemeConfig.blocks
    # ... rest of function
}
```

#### **Conditional Block Display**
```powershell
# Filter blocks based on conditions
$enabledBlocks = $blocks | Where-Object { 
    $_.enabled -ne $false -and 
    # Add custom conditions:
    ($_.type -ne 'time' -or (Get-Date).Hour -lt 18)  # Hide time after 6 PM
}
```

## 🎨 **4. Practical Examples**

### **Example 1: Cyberpunk Retro-Neon Customization**

**File**: `core/retro-neon/colors.ps1`
```powershell
$RetroNeonColors = @{
    'primary' = '#FF00FF'      # Bright magenta
    'secondary' = '#00FFFF'    # Cyan
    'accent' = '#FFFF00'       # Yellow
    'text' = '#FFFFFF'         # White
    'glow' = '#FF00AA'         # Pink glow effect
}

function Write-RetroNeonGlowText {
    param([string]$Text)
    Write-Host "◄" -ForegroundColor $RetroNeonColors.glow -NoNewline
    Write-Host $Text -ForegroundColor $RetroNeonColors.text -NoNewline  
    Write-Host "►" -ForegroundColor $RetroNeonColors.glow -NoNewline
}
```

**File**: `core/retro-neon/utils.ps1` (Render-Block function)
```powershell
# Replace standard rendering with cyberpunk style
$paddedContent = "░▒▓ $Content ▓▒░"
Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -BackgroundColor $Block.background -NoNewline
```

### **Example 2: Minimal Corporate Theme**

**File**: `core/minimal/colors.ps1`
```powershell
$MinimalColors = @{
    'primary' = 'DarkBlue'     # Corporate blue
    'secondary' = 'Gray'       # Subtle background
    'accent' = 'White'         # Clean highlights
    'text' = 'White'           # Clear text
}
```

**File**: `core/minimal/utils.ps1`
```powershell
# Ultra-clean rendering
$paddedContent = "$Content"  # No extra padding
Write-ColoredText -Text $paddedContent -ForegroundColor $Block.foreground -NoNewline

# Simple separators
if (-not $IsLast) {
    Write-Host " • " -ForegroundColor 'DarkGray' -NoNewline
}
```

### **Example 3: Gaming Theme with Custom Icons**

**File**: `core/gradient-modern/utils.ps1`
```powershell
# Gaming-themed icon customization
if ($Block.icon) {
    $gameIcon = switch ($Block.type) {
        'username' { '🎮' }
        'directory' { '🗂️' }
        'git-branch' { '🌿' }
        'time' { '⏰' }
        default { $Block.icon }
    }
    $Content = "$gameIcon $Content"
}
```

## 🔄 **5. Testing Your Changes**

```powershell
# Reload the framework to test changes
. .\core\utils.ps1
. .\core\prompt.ps1

# Switch to your modified theme
Set-PSTheme your-theme-name

# Test the prompt
prompt
```

## 🔙 **6. Backing Up & Restoring**

### **Backup Before Modifying**
```powershell
# Create backup of theme folder
Copy-Item "core\gradient-modern" "core\gradient-modern-backup" -Recurse
```

### **Restore Original**
```powershell
# Restore from backup
Remove-Item "core\gradient-modern" -Recurse -Force
Rename-Item "core\gradient-modern-backup" "core\gradient-modern"
```

## 🎯 **7. Best Practices**

### **✅ Do**
- Test changes incrementally
- Keep backups of working themes
- Use descriptive variable names
- Comment your customizations
- Test in different terminals

### **❌ Avoid**
- Modifying core utility functions (they're shared)
- Breaking PowerShell syntax
- Removing required function parameters
- Changing function names that are called elsewhere

## 🆘 **8. Troubleshooting**

### **Theme Not Loading**
```powershell
# Check for syntax errors
Test-PSThemeSetup

# Reload framework
. .\core\utils.ps1
. .\core\prompt.ps1
```

### **Colors Not Showing**
- Verify terminal supports ANSI colors
- Check color names are valid PowerShell colors
- Test with Windows Terminal for best compatibility

### **Prompt Broken**
```powershell
# Quick fix: switch to default theme
Set-PSTheme default

# Or restore PowerShell default prompt temporarily
function prompt { "PS $($PWD.Path)> " }
```

## 🎉 **Ready to Customize!**

You now have complete control over every aspect of your themes. Each theme is fully independent, so experiment freely without worrying about breaking other themes!

### **Next Steps**
- [🎨 Creating New Themes](creating-themes.md) - Build themes from scratch
- [🏗️ Architecture Guide](architecture.md) - Understand the technical details  
- [📚 Usage Guide](usage.md) - Advanced usage patterns