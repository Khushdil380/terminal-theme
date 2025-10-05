# Custom Theme Creation Guide

Learn how to create your own beautiful PowerShell themes with this comprehensive guide.

## 🎨 Theme Design Philosophy

Before creating a theme, consider these design principles:

1. **Readability**: Ensure good contrast between text and background
2. **Information Hierarchy**: Most important info should stand out
3. **Visual Flow**: Use colors and separators to guide the eye
4. **Terminal Compatibility**: Test on different terminals
5. **Performance**: Don't include unnecessary blocks

## 📋 Theme File Structure

Every theme is a JSON file with this basic structure:

```json
{
  "name": "Your Theme Name",
  "description": "Brief description of your theme",
  "version": "1.0.0",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#ffffff",
  "blocks": [
    // Array of block configurations
  ]
}
```

### Metadata Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Display name for your theme |
| `description` | No | Brief description of the theme |
| `version` | No | Version string (semantic versioning recommended) |
| `prompt_symbol` | No | Final prompt symbol (defaults to chevron) |
| `prompt_symbol_color` | No | Color of the prompt symbol |

## 🧩 Block Configuration

Each block in the `blocks` array represents a component of your prompt.

### Basic Block Structure

```json
{
  "type": "block_type",           // Required: username, hostname, directory, etc.
  "enabled": true,                // Optional: whether to show this block
  "foreground": "#ffffff",        // Required: text color
  "background": "#0078d4",        // Required: background color
  "icon": "nerd:user",           // Optional: icon to display
  "separator": "powerline:right-arrow", // Optional: separator style
  "separator_color": "#0078d4",   // Optional: separator color
  "template": "{{variable}}"      // Optional: custom formatting
}
```

### Available Block Types

#### 1. Username Block
```json
{
  "type": "username",
  "foreground": "#ffffff",
  "background": "#0078d4",
  "icon": "nerd:user",            // or "👤"
  "template": "{{username}}"      // Available: {{username}}
}
```

#### 2. Hostname Block
```json
{
  "type": "hostname", 
  "foreground": "#ffffff",
  "background": "#106ebe",
  "icon": "nerd:computer",        // or "🖥"
  "template": "{{hostname}}"      // Available: {{hostname}}
}
```

#### 3. Directory Block
```json
{
  "type": "directory",
  "foreground": "#ffffff", 
  "background": "#2d5016",
  "icon": "nerd:folder",          // or "📁"
  "max_length": 50,               // Path compression length
  "template": "{{path}}"          // Available: {{path}}
}
```

#### 4. Git Branch Block
```json
{
  "type": "git-branch",
  "foreground": "#ffffff",
  "background": "#f14c4c", 
  "icon": "nerd:git-branch",      // or ""
  "show_status": true,            // Show git status indicators
  "staged_icon": "✓",             // Icon for staged changes
  "changes_icon": "●",            // Icon for unstaged changes
  "untracked_icon": "?",          // Icon for untracked files
  "template": "{{branch}} {{status}}" // Available: {{branch}}, {{status}}
}
```

#### 5. Time Block
```json
{
  "type": "time",
  "foreground": "#000000",
  "background": "#ffff00",
  "icon": "nerd:clock",           // or "⏰"
  "format": "HH:mm:ss",          // .NET DateTime format string
  "template": "{{time}}"          // Available: {{time}}, {{date}}
}
```

#### 6. Symbol Block
```json
{
  "type": "symbol",
  "foreground": "#ffffff",
  "background": "#8000ff",
  "symbol_type": "admin",         // admin, exit_code, custom, nerd_font
  "admin_symbol": "#",            // Symbol when running as admin
  "user_symbol": "$",             // Symbol when running as user
  "success_symbol": "✓",          // Symbol when last command succeeded
  "error_symbol": "✗",            // Symbol when last command failed
  "symbol": "◆",                  // Custom symbol
  "icon_name": "star",            // Nerd font icon name
  "template": "{{symbol}}"        // Available: {{symbol}}
}
```

## 🎨 Color Guidelines

### Choosing Colors

1. **Use hex colors** for precise control: `#ff0000`
2. **Named colors** are also supported: `red`, `blue`, `bright-green`
3. **Test contrast** - ensure text is readable on background
4. **Consider colorblind users** - don't rely only on color for information

### Color Palette Suggestions

#### Professional Blue Theme
```json
{
  "username": { "bg": "#0078d4", "fg": "#ffffff" },
  "hostname": { "bg": "#106ebe", "fg": "#ffffff" },
  "directory": { "bg": "#005a9e", "fg": "#ffffff" },
  "git": { "bg": "#004578", "fg": "#ffffff" }
}
```

#### Warm Gradient Theme
```json
{
  "username": { "bg": "#ff6b6b", "fg": "#ffffff" },
  "hostname": { "bg": "#ff8e53", "fg": "#ffffff" },
  "directory": { "bg": "#ff6348", "fg": "#ffffff" },
  "git": { "bg": "#ff4757", "fg": "#ffffff" }
}
```

#### Cool Monochrome Theme
```json
{
  "username": { "bg": "#2c3e50", "fg": "#ecf0f1" },
  "hostname": { "bg": "#34495e", "fg": "#ecf0f1" },
  "directory": { "bg": "#95a5a6", "fg": "#2c3e50" },
  "git": { "bg": "#7f8c8d", "fg": "#2c3e50" }
}
```

## 🔤 Icons and Separators

### Nerd Font Icons

Use the `nerd:` prefix for built-in Nerd Font icons:

```json
"icon": "nerd:user"        // 👤
"icon": "nerd:computer"    // 🖥
"icon": "nerd:folder"      // 📁
"icon": "nerd:git-branch"  // 
"icon": "nerd:clock"       // ⏰
```

### Custom Unicode Icons

You can use any Unicode character:

```json
"icon": "👤"    // User
"icon": "🏠"    // Home  
"icon": "📁"    // Folder
"icon": "🚀"    // Rocket
"icon": "⚡"    // Lightning
"icon": "🔥"    // Fire
"icon": "💎"    // Diamond
"icon": "🎯"    // Target
```

### Powerline Separators

Use powerline-style separators for a connected look:

```json
"separator": "powerline:right-arrow"  // 
"separator": "powerline:left-arrow"   // 
"separator": "powerline:right-thin"   // 
"separator": "powerline:left-thin"    // 
```

### Custom Separators

Or use any Unicode character:

```json
"separator": "▶"
"separator": "│"
"separator": "┃"
"separator": "▸"
```

## 📝 Templates and Formatting

Templates allow you to customize how information is displayed using placeholder variables.

### Template Variables by Block Type

| Block Type | Variables | Example Template |
|------------|-----------|------------------|
| username | `{{username}}` | `"🧑 {{username}}"` |
| hostname | `{{hostname}}` | `"💻 {{hostname}}"` |
| directory | `{{path}}` | `"📁 {{path}}"` |
| git-branch | `{{branch}}`, `{{status}}` | `"🌿 {{branch}} {{status}}"` |
| time | `{{time}}`, `{{date}}` | `"🕐 {{time}}"` |
| symbol | `{{symbol}}` | `"{{symbol}}"` |

### Template Examples

```json
// Show username with custom prefix
{
  "type": "username",
  "template": "User: {{username}}"
}

// Show directory with custom formatting
{
  "type": "directory", 
  "template": "📂 {{path}}"
}

// Show git branch with custom status
{
  "type": "git-branch",
  "template": "[{{branch}}{{status}}]"
}

// Show time with date
{
  "type": "time",
  "format": "HH:mm:ss",
  "template": "{{date}} {{time}}"
}
```

## 🎯 Complete Theme Examples

### Example 1: Corporate Theme

```json
{
  "name": "Corporate",
  "description": "Professional theme for corporate environments",
  "version": "1.0.0",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#0078d4",
  "blocks": [
    {
      "type": "username",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#0078d4",
      "icon": "👤",
      "separator": "powerline:right-arrow",
      "separator_color": "#0078d4"
    },
    {
      "type": "directory",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#005a9e",
      "icon": "📁",
      "separator": "powerline:right-arrow",
      "separator_color": "#005a9e",
      "max_length": 40
    },
    {
      "type": "git-branch",
      "enabled": true,
      "foreground": "#ffffff", 
      "background": "#dc3545",
      "icon": "",
      "separator": "powerline:right-arrow",
      "separator_color": "#dc3545",
      "show_status": true,
      "staged_icon": "●",
      "changes_icon": "!",
      "untracked_icon": "?"
    }
  ]
}
```

### Example 2: Developer Theme

```json
{
  "name": "Developer",
  "description": "Theme optimized for software development",
  "version": "1.0.0",
  "prompt_symbol": "symbol:lambda",
  "prompt_symbol_color": "#00d7ff",
  "blocks": [
    {
      "type": "directory",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#2e3440",
      "icon": "📂",
      "separator": "powerline:right-arrow",
      "separator_color": "#2e3440",
      "max_length": 35
    },
    {
      "type": "git-branch",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#a3be8c",
      "icon": "",
      "separator": "powerline:right-arrow", 
      "separator_color": "#a3be8c",
      "show_status": true,
      "staged_icon": "✓",
      "changes_icon": "●",
      "untracked_icon": "○",
      "template": "{{branch}} {{status}}"
    },
    {
      "type": "time",
      "enabled": true,
      "foreground": "#2e3440",
      "background": "#88c0d0",
      "icon": "🕐",
      "separator": "",
      "format": "HH:mm",
      "template": "{{time}}"
    }
  ]
}
```

### Example 3: Minimalist Theme

```json
{
  "name": "Minimalist",
  "description": "Clean and simple theme with minimal visual elements",
  "version": "1.0.0",
  "prompt_symbol": "symbol:arrow",
  "prompt_symbol_color": "#6c7086",
  "blocks": [
    {
      "type": "directory",
      "enabled": true,
      "foreground": "#4c4f69",
      "background": "",
      "icon": "",
      "separator": "",
      "max_length": 60,
      "template": "{{path}}"
    },
    {
      "type": "git-branch",
      "enabled": true,
      "foreground": "#40a02b",
      "background": "",
      "icon": "",
      "separator": "",
      "show_status": true,
      "staged_icon": "+",
      "changes_icon": "~",
      "untracked_icon": "?",
      "template": " ({{branch}}{{status}})"
    }
  ]
}
```

## 🛠 Development Workflow

### 1. Create Your Theme File

```powershell
# Create new theme file
New-Item "themes\my-theme.json" -ItemType File

# Copy from existing theme as starting point
Copy-Item "themes\default.json" "themes\my-theme.json"
```

### 2. Edit and Test

```powershell
# Edit your theme
notepad themes\my-theme.json

# Apply for testing
Set-PSTheme my-theme

# Or use the script for more options
.\scripts\change-theme.ps1 -Theme my-theme
```

### 3. Iterate and Refine

```powershell
# Make changes to your theme file
# Then reload to see changes
.\scripts\apply-theme.ps1

# Or switch away and back
Set-PSTheme default
Set-PSTheme my-theme
```

### 4. Test Thoroughly

Test your theme in different scenarios:

```powershell
# Test in different directories
cd ~
cd C:\
cd "C:\Program Files"

# Test in git repositories
cd path\to\git\repo
git status  # Make some changes to test git status display

# Test with long paths
cd "C:\Very\Long\Path\With\Many\Nested\Directories\That\Should\Test\Path\Compression"

# Test with special characters in path
cd "C:\Path With Spaces\And-Dashes\And_Underscores"
```

## 🎨 Design Tips

### Color Harmony

1. **Use color palette generators**:
   - [Coolors.co](https://coolors.co/)
   - [Adobe Color](https://color.adobe.com/)
   - [Paletton](https://paletton.com/)

2. **Follow color theory**:
   - Analogous colors (next to each other on color wheel)
   - Complementary colors (opposite on color wheel)
   - Triadic colors (three evenly spaced colors)

3. **Test accessibility**:
   - Use [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
   - Ensure 4.5:1 contrast ratio minimum

### Visual Flow

1. **Left to right progression**: Most important info on the left
2. **Color intensity**: Brighten colors for important info
3. **Size and spacing**: Use icons and separators to create rhythm

### Performance Considerations

1. **Limit blocks**: More blocks = slower prompt
2. **Git status**: Expensive operation, consider disabling in large repos
3. **Path compression**: Use `max_length` to prevent overly long prompts

## 🧪 Testing Your Theme

### Basic Functionality Test

```powershell
# Test theme loading
Set-PSTheme your-theme-name

# Test in different locations
cd ~
cd C:\
cd "C:\Program Files"

# Test with git
cd path\to\git\repo
# Make some changes and test git status display
```

### Visual Testing

1. **Test in different terminals**:
   - Windows Terminal
   - VS Code integrated terminal
   - ConEmu
   - Default PowerShell console

2. **Test with different fonts**:
   - With Nerd Font
   - Without Nerd Font
   - Different terminal sizes

3. **Test color visibility**:
   - Light terminal backgrounds
   - Dark terminal backgrounds
   - High contrast mode

### Performance Testing

```powershell
# Measure prompt rendering time
Measure-Command { prompt }

# Test in large git repository
cd path\to\large\repo
Measure-Command { prompt }

# Test with long paths
cd "very\long\path\with\many\components"
```

## 📤 Sharing Your Theme

### Documentation

When sharing your theme, include:

1. **Theme name and description**
2. **Screenshots** showing the theme in action
3. **Requirements** (fonts, terminal features)
4. **Installation instructions**
5. **Customization options**

### Example Theme Documentation

```markdown
# My Awesome Theme

A vibrant theme inspired by sunset colors.

## Preview
![Theme Preview](preview.png)

## Features
- Warm gradient colors
- Git status integration
- Compressed paths for readability
- Nerd Font icons

## Requirements
- Nerd Font (FiraCode Nerd Font recommended)
- Terminal with ANSI color support
- Git (for git status display)

## Installation
1. Copy `my-awesome-theme.json` to your `themes/` directory
2. Run: `Set-PSTheme my-awesome-theme`

## Customization
- Change `max_length` in directory block to adjust path compression
- Disable git status by setting `show_status: false` for better performance
```

## 🔧 Advanced Techniques

### Conditional Blocks

You can create themes that adapt to different situations by using the `enabled` property strategically:

```json
// Theme that shows time only during work hours
{
  "type": "time",
  "enabled": true,  // You can modify this programmatically
  "template": "{{time}}"
}
```

### Dynamic Color Schemes

Create multiple variations of your theme for different contexts:

```json
// my-theme-dark.json
{
  "name": "My Theme Dark",
  "blocks": [
    {
      "type": "directory",
      "foreground": "#ffffff",
      "background": "#2d3748"
    }
  ]
}

// my-theme-light.json  
{
  "name": "My Theme Light",
  "blocks": [
    {
      "type": "directory", 
      "foreground": "#2d3748",
      "background": "#f7fafc"
    }
  ]
}
```

### Environment-Specific Customization

You can create setup logic in your profile to load different themes based on environment:

```powershell
# Add to your PowerShell profile after theme framework loads

# Load different themes based on time of day
$hour = (Get-Date).Hour
if ($hour -lt 6 -or $hour -gt 18) {
    Set-PSTheme my-theme-dark
} else {
    Set-PSTheme my-theme-light
}

# Or based on current directory
if ($PWD.Path -like "*\work\*") {
    Set-PSTheme work-theme
} elseif ($PWD.Path -like "*\personal\*") {
    Set-PSTheme personal-theme
}
```

## 📚 Additional Resources

### Color Tools
- [Coolors](https://coolors.co/) - Color palette generator
- [Adobe Color](https://color.adobe.com/) - Professional color tools
- [Contrast Checker](https://webaim.org/resources/contrastchecker/) - Accessibility testing

### Unicode Resources
- [Unicode Table](https://unicode-table.com/) - Browse Unicode characters
- [Emojipedia](https://emojipedia.org/) - Emoji reference
- [Nerd Fonts Cheat Sheet](https://www.nerdfonts.com/cheat-sheet) - Icon reference

### Design Inspiration
- [oh-my-posh themes](https://ohmyposh.dev/docs/themes) - Theme gallery
- [Starship presets](https://starship.rs/presets/) - More theme ideas
- Terminal screenshot galleries on GitHub

---

Happy theming! 🎨 Create something beautiful and share it with the community.