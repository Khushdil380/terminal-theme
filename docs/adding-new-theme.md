# Adding a New Theme

This guide explains how to create and add a new theme to the PowerShell Theme Framework.

## Overview

Adding a new theme involves creating a JSON configuration file that defines the visual appearance and behavior of your prompt blocks. The framework will automatically detect and make your theme available.

## Core Process

### 1. Create Theme File

Create a new JSON file in the `themes/` directory:

```
themes/
├── your-theme-name.json  ← Create this file
├── default.json
├── retro-neon.json
├── gradient-modern.json
└── minimal.json
```

**File naming convention:**
- Use lowercase letters and hyphens
- Must end with `.json`
- Example: `cyberpunk-blue.json`, `corporate-clean.json`

### 2. Theme Structure

Your theme file must follow this JSON structure:

```json
{
  "name": "Your Theme Display Name",
  "description": "Brief description of your theme",
  "version": "1.0.0",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#ffffff",
  "blocks": [
    // Block configurations go here
  ]
}
```

### 3. Configure Blocks

Each block in the `blocks` array represents a prompt segment:

```json
{
  "type": "username",           // Block type (see available types below)
  "enabled": true,              // Show/hide this block
  "foreground": "#ffffff",      // Text color (hex or name)
  "background": "#0066cc",      // Background color (hex or name)
  "icon": "[USER]",             // Icon or nerd font icon
  "separator": "powerline:right-arrow",  // Separator style
  "separator_color": "#0066cc", // Separator color
  "template": "{{username}}"    // Content template
}
```

## Available Block Types

| Type | Purpose | Special Properties |
|------|---------|-------------------|
| `username` | Current user | `template` |
| `hostname` | Computer name | `template` |
| `directory` | Current path | `max_length`, `template` |
| `git-branch` | Git information | `show_status`, `staged_icon`, `changes_icon`, `untracked_icon` |
| `time` | Current time | `format` (e.g., "HH:mm") |
| `symbol` | Prompt symbol | Uses global `prompt_symbol` setting |

## Color Options

### Hex Colors (Recommended)
```json
"foreground": "#ffffff",
"background": "#0066cc"
```

### Named Colors
```json
"foreground": "white",
"background": "blue"
```

**Supported named colors:** `black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`, `darkred`, `darkgreen`, `darkyellow`, `darkblue`, `darkmagenta`, `darkcyan`, `gray`, `darkgray`

## Separator Styles

| Style | Description | Visual |
|-------|-------------|---------|
| `powerline:right-arrow` | Right-pointing triangle | ▶ |
| `powerline:left-arrow` | Left-pointing triangle | ◀ |
| `powerline:right-thin` | Thin right angle | ❯ |
| `powerline:left-thin` | Thin left angle | ❮ |
| `powerline:separator` | Vertical line | │ |
| `"|"` | Pipe character | \| |
| `" "` | Space separator |   |

## Icon Options

### Text Icons
```json
"icon": "[USER]",
"icon": "[DIR]",
"icon": "[GIT]"
```

### Nerd Font Icons (if supported)
```json
"icon": "nerd:user",
"icon": "nerd:folder",
"icon": "nerd:git-branch"
```

## Example Theme

Here's a complete example theme:

```json
{
  "name": "Ocean Blue",
  "description": "Calming ocean-inspired blue theme",
  "version": "1.0.0",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#4fc3f7",
  "blocks": [
    {
      "type": "username",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#0277bd",
      "icon": "[USER]",
      "separator": "powerline:right-arrow",
      "separator_color": "#0277bd",
      "template": "{{username}}"
    },
    {
      "type": "directory",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#0288d1",
      "icon": "[DIR]",
      "separator": "powerline:right-arrow",
      "separator_color": "#0288d1",
      "max_length": 50,
      "template": "{{path}}"
    },
    {
      "type": "git-branch",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#039be5",
      "icon": "[GIT]",
      "separator": "",
      "separator_color": "#039be5",
      "show_status": true,
      "staged_icon": "+",
      "changes_icon": "!",
      "untracked_icon": "?",
      "template": "{{branch}} {{status}}"
    }
  ]
}
```

## Testing Your Theme

1. Save your theme file in the `themes/` directory
2. Reload the PowerShell session or run: `. .\core\prompt.ps1`
3. Check available themes: `Get-PSThemes`
4. Apply your theme: `Set-PSTheme your-theme-name`

## Best Practices

### Color Harmony
- Use consistent color palettes
- Ensure good contrast between foreground and background
- Consider accessibility for colorblind users

### Performance
- Avoid too many enabled blocks (impacts prompt speed)
- Set reasonable `max_length` for directory paths
- Disable unused blocks with `"enabled": false`

### Visual Design
- Use powerline separators for smooth transitions
- Keep icons consistent in style
- Test in different terminal applications

### Theme Naming
- Use descriptive names that reflect the theme's style
- Follow kebab-case naming convention
- Keep file names concise but clear

## Color Mapping

The framework automatically maps hex colors to terminal colors. If you use custom hex colors, add them to the color mapping in `core/utils.ps1`:

```powershell
# Your theme colors
'#0277bd' = 'DarkBlue'
'#0288d1' = 'Blue' 
'#039be5' = 'Cyan'
```

## Troubleshooting

### Theme Not Appearing
- Check JSON syntax is valid
- Ensure file is in `themes/` directory
- Verify file extension is `.json`
- Reload PowerShell session

### Colors Not Displaying
- Add custom hex colors to `core/utils.ps1`
- Use named colors as fallback
- Test in different terminal applications

### Blocks Not Showing
- Check `"enabled": true` is set
- Verify block type is supported
- Ensure required properties are present

---

For more examples, examine the existing themes in the `themes/` directory and refer to the main documentation.