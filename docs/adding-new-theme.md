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

## Advanced: True Powerline Styling

For professional oh-my-posh style themes with seamless arrow transitions, use the advanced powerline configuration:

### Powerline Theme Structure

```json
{
  "name": "My Powerline Theme",
  "description": "Professional powerline theme with seamless transitions",
  "version": "1.0.0",
  "style": "powerline",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#e91e63",
  "leading_diamond": "\\uE0B6",
  "trailing_diamond": "\\uE0B4", 
  "powerline_symbol": "\\uE0B0",
  "blocks": [
    // Powerline block configurations
  ]
}
```

### Powerline Block Configuration

```json
{
  "type": "username",
  "enabled": true,
  "foreground": "#ffffff",
  "background": "#e91e63",
  "icon": "\\uF007",
  "separator": "powerline:right-arrow",
  "separator_color": "#e91e63",
  "powerline_symbol": "\\uE0B0",
  "leading_diamond": "\\uE0B6",
  "template": "{{username}}"
}
```

### Key Powerline Properties

| Property | Purpose | Example |
|----------|---------|---------|
| `style` | Enables powerline rendering mode | `"powerline"` |
| `leading_diamond` | Start symbol for first block | `"\\uE0B6"` (󰊖) |
| `trailing_diamond` | End symbol for last block | `"\\uE0B4"` (󰊔) |
| `powerline_symbol` | Arrow between blocks | `"\\uE0B0"` (󰊰) |

### Unicode Icon Reference

| Icon | Unicode | Description |
|------|---------|-------------|
| 󰀄 | `\\uF007` | User icon |
| 󰉋 | `\\uF07C` | Folder icon |
| 󰊢 | `\\uE0A0` | Git branch icon |
| 󰃰 | `\\uF0F3` | Bell/notification icon |
| 󰅐 | `\\uF150` | Time/clock icon |

### Color Transition Best Practices

1. **Seamless Arrows**: The framework automatically handles color transitions where:
   - Current block background becomes arrow foreground color
   - Next block background becomes arrow background color

2. **High Contrast**: Ensure good contrast between text and background:
   ```json
   "foreground": "#ffffff",  // White text
   "background": "#e91e63"   // Pink background
   ```

3. **Color Harmony**: Use complementary colors for smooth transitions:
   ```json
   // Example gradient: Pink → Cyan → Green
   { "background": "#e91e63" },  // Pink
   { "background": "#00bcd4" },  // Cyan  
   { "background": "#4caf50" }   // Green
   ```

### Font Requirements & Fallbacks

**Required for Powerline Icons:**
- Nerd Font (MesloLGS NF recommended)
- Powerline patched fonts
- Download from: [Nerd Fonts](https://www.nerdfonts.com/)

**Automatic Fallbacks:**
The framework provides automatic fallbacks when Nerd Fonts aren't available:
- `\\uE0B0` (󰊰) → `▶` (right triangle)
- `\\uE0B6` (󰊖) → `◆` (diamond)
- `\\uF007` (󰀄) → `[USER]` (text)

### Testing Across Terminals

Test your powerline theme in multiple environments:

1. **Windows Terminal** (best support)
2. **VSCode Integrated Terminal** 
3. **PowerShell ISE** (limited support)
4. **Windows Console Host** (fallback mode)

### Troubleshooting Powerline Issues

**Problem**: Arrows not showing seamlessly
**Solution**: Ensure `style: "powerline"` is set and blocks have proper background colors

**Problem**: Icons showing as squares/question marks  
**Solution**: Install a Nerd Font and set it as terminal font

**Problem**: Color gaps between blocks
**Solution**: Verify background colors are properly defined for all blocks

**Problem**: Theme loads but arrows missing
**Solution**: Check that `separator: "powerline:right-arrow"` is set on blocks

### Complete Powerline Theme Example

Here's a complete working powerline theme (like `arrows-modern`):

```json
{
  "name": "Professional Powerline",
  "description": "Complete powerline theme with seamless transitions",
  "version": "1.0.0",
  "style": "powerline",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#e91e63",
  "leading_diamond": "\\uE0B6",
  "trailing_diamond": "\\uE0B4",
  "powerline_symbol": "\\uE0B0",
  "blocks": [
    {
      "type": "username",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#e91e63",
      "icon": "\\uF007",
      "separator": "powerline:right-arrow",
      "separator_color": "#e91e63",
      "powerline_symbol": "\\uE0B0",
      "leading_diamond": "\\uE0B6",
      "template": "{{username}}"
    },
    {
      "type": "directory", 
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#00bcd4",
      "icon": "\\uF07C",
      "separator": "powerline:right-arrow",
      "separator_color": "#00bcd4",
      "powerline_symbol": "\\uE0B0",
      "max_length": 50,
      "template": "{{path}}"
    },
    {
      "type": "git-branch",
      "enabled": true,
      "foreground": "#ffffff", 
      "background": "#4caf50",
      "icon": "\\uE0A0",
      "separator": "powerline:right-arrow",
      "separator_color": "#4caf50",
      "powerline_symbol": "\\uE0B0",
      "trailing_diamond": "\\uE0B4",
      "show_status": true,
      "staged_icon": "+",
      "changes_icon": "!",
      "untracked_icon": "?",
      "template": "{{branch}} {{status}}"
    }
  ]
}
```

This creates: ` user  path  branch `

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

## Advanced Troubleshooting

### Common Issues and Solutions

**Issue**: Powerline arrows showing as regular triangles (▶) instead of seamless connections
**Root Cause**: Theme not properly configured for powerline rendering
**Solution**: 
1. Add `"style": "powerline"` to theme root
2. Ensure all blocks have `"separator": "powerline:right-arrow"`
3. Verify background colors are defined for proper color transitions

**Issue**: Icons appearing as squares or question marks
**Root Cause**: Terminal font doesn't support Unicode/Nerd Font glyphs
**Solution**:
1. Install a Nerd Font (MesloLGS NF recommended)
2. Set terminal to use the Nerd Font
3. Use fallback text icons: `"[USER]"` instead of `"\\uF007"`

**Issue**: Color gaps or black backgrounds between arrows
**Root Cause**: Incorrect color transition logic
**Solution**:
1. Ensure each block has a `background` color defined
2. Verify `separator_color` matches the block's background
3. Check that the renderer handles color inversion properly

**Issue**: Theme loads but displays incorrectly after restart
**Root Cause**: Cached theme configuration or deleted theme still referenced
**Solution**:
1. Check `config/current-theme.txt` for correct theme name
2. Reload framework: `. .\core\prompt.ps1`
3. Force set theme: `Set-PSTheme your-theme-name`

**Issue**: Git block not showing in git repositories
**Root Cause**: Git detection module returning null
**Solution**:
1. Ensure you're in a valid git repository
2. Check that `show_status` is set to `true`
3. Verify git is accessible from PowerShell

## Basic Troubleshooting

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