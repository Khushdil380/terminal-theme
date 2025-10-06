# PowerShell Theme Framework

[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  [![Platform](https://img.shields.io/badge/platform-Windows-blue.svg)](https://www.microsoft.com/windows)  [![Architecture](https://img.shields.io/badge/Architecture-Truly%20Modular-brightgreen.svg)](#-true-modularity)

A **truly modular** Windows PowerShell theme framework with **complete theme independence**. Each theme can be customized individually without affecting others.

## 🎯 **True Modularity** - NEW!

**✅ 100% Independent Themes**: Each theme has its own complete rendering logic  
**✅ Zero Core Dependencies**: Update any theme without touching core files  
**✅ Complete Customization**: Colors, spacing, separators, and behavior per theme  
**✅ Risk-Free Updates**: Modify one theme without breaking others  

## ✨ Features

- 🎯 **True Modularity** - Each theme is completely self-contained and independent
- 🎨 **Complete Customization** - Modify colors, spacing, separators, and behavior per theme
- 🧩 **Modular Blocks** - Easy to add, remove, or customize prompt blocks
- 📝 **JSON Configuration** - Simple theme definition using JSON files  
- 🎭 **5 Built-in Themes** - arrows-modern, gradient-modern, default, retro-neon, minimal
- 💾 **Theme Persistence** - Automatically saves and loads your preferred theme
- � **Nerd Font Support** - Beautiful icons and symbols with fallback
- 🌿 **Git Integration** - Branch, status, and changes automatically
- ⚙️ **Easy Management** - Simple commands and scripts
- 🌈 **Color Support** - Full ANSI colors with graceful fallback
- 💼 **Professional** - Modern, clean, customizable designs

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
| **arrows-modern** | Modern arrow-style theme with powerline separators and vibrant colors | Arrow design, colorful blocks | ![Arrows Modern Theme](assets/arrows-modern-preview.png) |

> **Note**: Screenshot previews show the themes in Windows Terminal with a Nerd Font. Actual appearance may vary based on your terminal and font configuration.
> 
> **🔤 Font Requirement**: The `arrows-modern` theme requires a **Nerd Font** (MesloLGS NF recommended) for proper Unicode icon display. Download from [Nerd Fonts](https://www.nerdfonts.com/).

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

## 🎯 **True Modular Architecture**

### **Individual Theme Customization**

Each theme is **completely independent** with its own dedicated folder:

```
core/{theme-name}/
├── colors.ps1     # 🎨 Colors, text styles, custom color functions
├── utils.ps1      # 🔧 Rendering logic, spacing, separators, icons
└── renderer.ps1   # 🎭 Theme structure, blocks, layout
```

### **What You Can Customize Per Theme:**

#### **🎨 Colors & Styling** (`colors.ps1`)
- Block background/foreground colors
- Text colors (command, error, success)
- Custom color palettes and functions
- Theme-specific color schemes

#### **🔧 Rendering & Spacing** (`utils.ps1`)  
- Block padding and spacing
- Separator styles and characters
- Icon handling and placement
- PowerLine arrow behavior
- Block rendering logic

#### **🎭 Structure & Layout** (`renderer.ps1`)
- Which blocks to display
- Block order and arrangement  
- Theme-specific conditional logic
- Overall prompt structure

### **✅ Complete Independence**

- **✅ Zero Risk**: Modify any theme without affecting others
- **✅ Full Control**: Customize every aspect of individual themes
- **✅ No Conflicts**: Themes never interfere with each other
- **✅ Easy Updates**: Change only what you want, where you want

## 🎨 **Theme Customization Examples**

### **Example 1: Change Colors**
```powershell
# Edit: core/gradient-modern/colors.ps1
$GradientModernColors = @{
    'primary' = 'Red'      # Change from Magenta to Red
    'secondary' = 'Yellow' # Change background color
    'command' = 'Green'    # Add custom command color
}
```

### **Example 2: Adjust Spacing**
```powershell
# Edit: core/gradient-modern/utils.ps1 - Line ~105
$paddedContent = "   $Content   "  # Triple spaces for more padding
```

### **Example 3: Custom Separators**
```powershell
# Edit: core/minimal/utils.ps1 - Non-powerline section
$paddedContent = "[ $Content ]"  # Use brackets instead of spaces
Write-Host " >> " -NoNewline     # Custom separator between blocks
```

## 📋 Requirements

- **Windows PowerShell 5.1+** or **PowerShell Core 6.0+**
- **Nerd Font** (recommended: MonaspiceXe Nerd Font Mono)
- **Git** (optional, for git branch display)
- **Terminal with ANSI support** (Windows Terminal, VS Code, etc.)

## 📖 Documentation

### **🎯 Theme Customization**
- **[� Updating Existing Themes](docs/updating-themes.md)** - Customize colors, spacing, separators
- **[🎨 Creating New Themes](docs/creating-themes.md)** - Step-by-step theme creation guide
- **[🏗️ Architecture Guide](docs/architecture.md)** - Understanding the modular structure

### **📚 General Documentation**  
- **[📚 Usage Guide](docs/usage.md)** - Complete usage instructions
- **[📋 API Reference](docs/README.md)** - Detailed technical documentation
- **[🚀 Quick Examples](docs/examples.md)** - Common customization examples

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