# PowerShell Theme Framework

[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Windows-blue.svg)](https://www.microsoft.com/windows)

A modular Windows PowerShell theme framework inspired by oh-my-posh, designed for easy customization and professional-looking prompts.

## ✨ Features

- 🧩 **Modular Design** - Easy to add, remove, or customize prompt blocks
- 🎨 **JSON Configuration** - Simple theme definition using JSON files  
- 🎭 **Multiple Themes** - Built-in themes: default, retro-neon, gradient-modern, minimal
- � **Theme Persistence** - Automatically saves and loads your preferred theme across sessions
- �🔠 **Nerd Font Support** - Beautiful icons and symbols using Nerd Fonts
- 🌿 **Git Integration** - Shows branch, status, and changes automatically
- ⚙️ **Easy Management** - Simple install/uninstall scripts
- 🌈 **ANSI Support** - Full color support with graceful fallback
- 💼 **Professional** - Modern, clean prompt designs

## 🚀 Quick Start

```powershell
# 1. Clone or download this repository
git clone https://github.com/Khushdil380/terminal-theme.git PowerShell-Themes

# 2. Navigate to the directory
cd PowerShell-Themes

# 3. Install the framework
.\scripts\install.ps1

# 4. Restart PowerShell or reload profile
. $PROFILE

# 5. Try different themes
Set-PSTheme retro-neon
Set-PSTheme gradient-modern
Set-PSTheme minimal
```

## 🎨 Available Themes

| Theme | Description | Style | Preview |
|-------|-------------|-------|---------|
| **default** | Professional blue theme with clean powerline separators | Corporate, clean | ![Default Theme](assets/default-preview.png) |
| **retro-neon** | Cyberpunk-inspired theme with bright neon colors | Retro-futuristic, vibrant | ![Retro Neon Theme](assets/retro-neon-preview.png) |
| **gradient-modern** | Modern purple gradient with smooth transitions | Contemporary, sleek | ![Gradient Modern Theme](assets/gradient-modern-preview.png) |
| **minimal** | Clean and minimal with subtle colors | Minimalist, distraction-free | ![Minimal Theme](assets/minimal-preview.png) |
...existing code...

> **Note**: Screenshot previews show the themes in Windows Terminal with a Nerd Font. Actual appearance may vary based on your terminal and font configuration.

## 📁 Project Structure

```
PowerShell-Themes/
├── 📁 themes/          # Theme JSON configurations
├── 📁 core/            # Core framework logic  
├── 📁 modules/         # Modular prompt blocks
├── 📁 scripts/         # Management scripts
├── 📁 docs/            # Comprehensive documentation
└── 📁 assets/          # Preview images and resources
```

## 🔧 Basic Commands

```powershell
# List all available themes
Get-PSThemes

# Change theme (automatically persists across sessions)
Set-PSTheme <theme-name>

# Get current theme information
Get-PSThemeInfo

# Test framework installation
Test-PSThemeSetup
```

### Theme Persistence

Themes are automatically saved when you change them with `Set-PSTheme`. Your selected theme will persist across:
- ✅ New PowerShell tabs
- ✅ New PowerShell windows  
- ✅ System restarts
- ✅ Terminal application restarts

## 📋 Requirements

- **Windows PowerShell 5.1+** or **PowerShell Core 6.0+**
- **Nerd Font** (recommended: MonaspiceXe Nerd Font Mono)
- **Git** (optional, for git branch display)
- **Terminal with ANSI support** (Windows Terminal, VS Code, etc.)

## 📖 Documentation

- **[📚 Usage Guide](docs/usage.md)** - Complete usage instructions
- **[🎨 Theme Creation](docs/create-theme.md)** - How to create custom themes
- **[📋 API Reference](docs/README.md)** - Detailed technical documentation

## 🛠 Management Scripts

| Script | Purpose |
|--------|---------|
| `install.ps1` | Install theme framework to PowerShell profile |
| `uninstall.ps1` | Remove theme framework and restore default |
| `change-theme.ps1` | Switch between themes with preview options |
| `apply-theme.ps1` | Apply/reload current theme configuration |

## 🎯 Example Usage

```powershell
# Install with specific theme
.\scripts\install.ps1 -ThemeName retro-neon

# List themes with descriptions
.\scripts\change-theme.ps1 -List

# Preview a theme before applying
.\scripts\change-theme.ps1 -Theme gradient-modern -Preview

# Switch theme temporarily
Set-PSTheme minimal

# Make theme change permanent
.\scripts\install.ps1 -ThemeName minimal -Force
```

## 🎨 Customization

Create your own themes by:

1. **Copying** an existing theme JSON file
2. **Modifying** colors, icons, and layouts
3. **Testing** with `Set-PSTheme your-theme`
4. **Sharing** with the community

See the [Theme Creation Guide](docs/create-theme.md) for detailed instructions.

## 🧩 Available Blocks

| Block | Description | Icons |
|-------|-------------|-------|
| **username** | Current user name | 👤 🧑 |
| **hostname** | Computer name | 🖥 💻 |
| **directory** | Current path with compression | 📁 📂 🏠 |
| **git-branch** | Git branch and status | 🌿  |
| **time** | Current time/date | ⏰ 🕐 📅 |
| **symbol** | Custom symbols and status | ❯ ➜ λ ▶ |

## 🔧 Advanced Features

- **Path Compression** - Automatically shortens long directory paths
- **Git Status Indicators** - Shows staged, unstaged, and untracked files
- **Admin Detection** - Different symbols for admin vs user sessions
- **Exit Code Display** - Visual feedback for command success/failure
- **Template System** - Customize how information is displayed
- **Conditional Blocks** - Enable/disable blocks based on context

## 🐛 Troubleshooting

### Common Issues

**Colors not displaying properly?**
- Ensure your terminal supports ANSI colors
- Try Windows Terminal or VS Code integrated terminal

**Icons showing as squares?**
- Install a Nerd Font (MonaspiceXe Nerd Font Mono recommended)
- Set your terminal to use the Nerd Font

**Git information not showing?**
- Ensure Git is installed and in your PATH
- Navigate to a Git repository to see git blocks

**Theme not persisting after restart?**
- Themes should automatically persist when using `Set-PSTheme <theme>`
- Check if `config/current-theme.txt` exists and contains your theme name
- If issues persist, reinstall with `.\scripts\install.ps1 -Force`

Run `Test-PSThemeSetup` to diagnose installation issues.

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add your theme or enhancement
4. Test thoroughly on different terminals
5. Submit a pull request

### Areas for Contribution

- 🎨 New theme designs
- 🧩 Additional prompt blocks/modules
- 🐛 Bug fixes and improvements
- 📖 Documentation enhancements
- 🧪 Testing on different PowerShell versions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by [oh-my-posh](https://ohmyposh.dev/) - Amazing cross-platform prompt theme engine
- [Nerd Fonts](https://www.nerdfonts.com/) - Iconic font aggregator and collection
- PowerShell community for inspiration and feedback

## 🌟 Show Your Support

If you find this project helpful:

- ⭐ Star this repository
- 🐛 Report issues or suggest improvements
- 🎨 Share your custom themes
- 📢 Tell others about it

---

**Made with ❤️ for the PowerShell community**

*Transform your PowerShell experience with beautiful, functional prompts!*