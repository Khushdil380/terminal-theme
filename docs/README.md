# PowerShell Theme Framework

A modular Windows PowerShell theme framework inspired by oh-my-posh, designed for easy customization and professional-looking prompts.

![PowerShell Theme Framework](assets/preview.png)

## 🌟 Features

- **Modular Design**: Easy to add, remove, or customize blocks
- **JSON Configuration**: Simple theme definition using JSON files
- **Multiple Themes**: Built-in themes (default, retro-neon, gradient-modern, minimal)
- **Nerd Font Support**: Beautiful icons and symbols using Nerd Fonts
- **Git Integration**: Shows branch, status, and changes
- **Easy Management**: Simple install/uninstall scripts
- **ANSI Support**: Full color support with graceful fallback
- **Professional Appearance**: Modern, clean prompt designs

## 📁 Project Structure

```
PowerShell-Themes/
│
├── themes/                        # Theme definitions (JSON files)
│   ├── default.json              # Professional default theme
│   ├── retro-neon.json           # Cyberpunk-inspired neon theme
│   ├── gradient-modern.json      # Modern gradient theme
│   └── minimal.json              # Clean minimal theme
│
├── core/                          # Core framework logic
│   ├── prompt.ps1                # Main prompt function and commands
│   ├── renderer.ps1              # Block rendering engine
│   └── utils.ps1                 # Utility functions and helpers
│
├── modules/                       # Modular blocks
│   ├── username.ps1              # Username display
│   ├── hostname.ps1              # Computer name display
│   ├── directory.ps1             # Current directory with compression
│   ├── git-branch.ps1            # Git branch and status
│   ├── time.ps1                  # Time/date display
│   └── symbol.ps1                # Custom symbols and indicators
│
├── scripts/                       # Management scripts
│   ├── install.ps1               # Install theme framework
│   ├── uninstall.ps1             # Remove theme framework
│   ├── apply-theme.ps1           # Apply/reload theme
│   └── change-theme.ps1          # Switch between themes
│
├── docs/                          # Documentation
│   ├── README.md                 # This file
│   ├── usage.md                  # Usage instructions
│   └── create-theme.md           # Custom theme creation guide
│
└── assets/                        # Preview images and resources
    └── preview.png
```

## 🚀 Quick Start

### Installation

1. **Download** or clone this repository to your desired location
2. **Install** the framework:
   ```powershell
   .\scripts\install.ps1
   ```
3. **Restart** PowerShell or reload your profile:
   ```powershell
   . $PROFILE
   ```

### Basic Usage

```powershell
# List available themes
Get-PSThemes

# Change theme
Set-PSTheme retro-neon

# Test installation
Test-PSThemeSetup

# Get current theme info
Get-PSThemeInfo
```

## 🎨 Available Themes

### Default Theme
Professional blue theme with clean powerline separators.
- **Colors**: Blue gradient with white text
- **Blocks**: Username, hostname, directory, git status
- **Style**: Corporate, professional

### Retro Neon
Cyberpunk-inspired theme with bright neon colors.
- **Colors**: Cyan, magenta, yellow, bright green
- **Blocks**: All blocks enabled with custom icons
- **Style**: Retro-futuristic, eye-catching

### Gradient Modern
Modern purple gradient theme with smooth transitions.
- **Colors**: Purple/violet gradient
- **Blocks**: Username, hostname, directory, git status
- **Style**: Modern, sleek

### Minimal
Clean and minimal theme with subtle colors.
- **Colors**: Gray/green subtle palette
- **Blocks**: Directory and git only
- **Style**: Minimal, distraction-free

## 🔧 Configuration

### Theme Structure

Themes are defined in JSON files with the following structure:

```json
{
  "name": "Theme Name",
  "description": "Theme description",
  "version": "1.0.0",
  "prompt_symbol": "symbol:chevron",
  "prompt_symbol_color": "#ffffff",
  "blocks": [
    {
      "type": "username",
      "enabled": true,
      "foreground": "#ffffff",
      "background": "#0078d4",
      "icon": "nerd:user",
      "separator": "powerline:right-arrow",
      "separator_color": "#0078d4",
      "template": "{{username}}"
    }
  ]
}
```

### Available Block Types

- `username` - Current user name
- `hostname` - Computer name
- `directory` - Current working directory
- `git-branch` - Git branch and status
- `time` - Current time/date
- `symbol` - Custom symbols and status indicators

### Icon Types

- `nerd:user`, `nerd:computer`, `nerd:folder`, `nerd:git-branch`, `nerd:clock`
- Custom Unicode symbols: `👤`, `🖥`, `📁`, `⏰`, etc.
- Powerline symbols: ``, ``, etc.

## 📋 Requirements

- **Windows PowerShell 5.1+** or **PowerShell Core 6.0+**
- **Nerd Font** (recommended: MonaspiceXe Nerd Font Mono)
- **Git** (optional, for git branch display)
- **Terminal with ANSI support** (Windows Terminal, VS Code, etc.)

## 🔧 Management Commands

### Installation Scripts

```powershell
# Install with default theme
.\scripts\install.ps1

# Install with specific theme
.\scripts\install.ps1 -ThemeName retro-neon

# Force reinstall
.\scripts\install.ps1 -Force

# Uninstall framework
.\scripts\uninstall.ps1

# Apply/reload current theme
.\scripts\apply-theme.ps1

# Change theme temporarily
.\scripts\change-theme.ps1 -Theme minimal

# List available themes
.\scripts\change-theme.ps1 -List

# Preview theme
.\scripts\change-theme.ps1 -Theme gradient-modern -Preview
```

### PowerShell Commands

Once installed, these commands are available in your PowerShell session:

```powershell
# Change theme
Set-PSTheme <theme-name>

# List all themes
Get-PSThemes

# Get current theme info
Get-PSThemeInfo

# Test framework setup
Test-PSThemeSetup
```

## 🐛 Troubleshooting

### Common Issues

1. **Colors not displaying properly**
   - Ensure your terminal supports ANSI colors
   - Try Windows Terminal or VS Code integrated terminal

2. **Icons not showing correctly**
   - Install a Nerd Font (MonaspiceXe Nerd Font Mono recommended)
   - Set your terminal to use the Nerd Font

3. **Git status not working**
   - Ensure Git is installed and in your PATH
   - Navigate to a Git repository

4. **Theme not loading**
   - Run `Test-PSThemeSetup` to diagnose issues
   - Check that all required files exist
   - Restart PowerShell

### Debug Commands

```powershell
# Test framework health
Test-PSThemeSetup

# Get detailed theme information
Get-PSThemeInfo

# Reload current theme
.\scripts\apply-theme.ps1
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add your theme or module
4. Test thoroughly
5. Submit a pull request

### Creating Custom Themes

See [create-theme.md](docs/create-theme.md) for detailed instructions on creating custom themes.

### Adding Custom Modules

1. Create a new `.ps1` file in the `modules/` directory
2. Implement a `Get-<ModuleName>Block` function
3. Add the module type to your theme JSON
4. Test and document your module

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by [oh-my-posh](https://ohmyposh.dev/)
- Icons provided by [Nerd Fonts](https://www.nerdfonts.com/)
- PowerShell community for inspiration and feedback

## 📞 Support

- Create an issue for bug reports
- Check existing issues for known problems
- Join the discussion for questions and ideas

---

**Made with ❤️ for the PowerShell community**