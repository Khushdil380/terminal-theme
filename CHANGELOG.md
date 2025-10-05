# Changelog

All notable changes to the PowerShell Theme Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-05

### Added
- **Complete PowerShell Theme Framework** - Modular theme system inspired by oh-my-posh
- **Theme Persistence System** - Automatically saves and loads user theme preferences across sessions
- **Four Built-in Themes**:
  - `default` - Professional blue corporate theme
  - `retro-neon` - Cyberpunk-inspired neon theme
  - `gradient-modern` - Contemporary purple gradient theme
  - `minimal` - Clean and distraction-free theme
- **Modular Block System** - Six configurable prompt blocks:
  - `username` - Current user display
  - `hostname` - Computer name display
  - `directory` - Current path with smart compression
  - `git-branch` - Git branch and status indicators
  - `time` - Current time/date display
  - `symbol` - Custom prompt symbols
- **JSON Theme Configuration** - Easy theme creation and customization
- **Git Integration** - Real-time branch detection and status indicators
- **Management Scripts**:
  - `install.ps1` - Framework installation
  - `uninstall.ps1` - Clean removal
  - `change-theme.ps1` - Interactive theme switching
  - `apply-theme.ps1` - Theme reloading
- **PowerShell Commands**:
  - `Set-PSTheme` - Change themes with automatic persistence
  - `Get-PSThemes` - List available themes
  - `Get-PSThemeInfo` - Display current theme information
  - `Test-PSThemeSetup` - Installation diagnostics
- **ANSI Color Support** - Full color support with graceful fallback for older terminals
- **Comprehensive Documentation** - Complete usage guides and API reference
- **Cross-terminal Compatibility** - Works with Windows Terminal, VS Code, and PowerShell ISE

### Technical Features
- **Global Scope Management** - Proper variable scoping for multi-session compatibility
- **Error Handling** - Graceful fallbacks for missing fonts, git, or terminal features
- **Path Compression** - Smart directory path shortening for long paths
- **Template System** - Customizable display templates for each block
- **Conditional Blocks** - Enable/disable blocks based on context or preferences

### Dependencies
- Windows PowerShell 5.1+ or PowerShell Core 6.0+
- Optional: Git (for git branch display)
- Optional: Nerd Font (for optimal icon display)

### Installation
- Automated installation via `install.ps1`
- PowerShell profile integration
- Backup and restore functionality
- Uninstall script for clean removal

## [Unreleased]

### Planned Features
- Theme screenshots and previews
- Additional built-in themes
- Custom block creation guide
- Performance optimizations
- Cross-platform PowerShell Core support
- Plugin system for community blocks

---

**Legend:**
- `Added` - New features
- `Changed` - Changes in existing functionality  
- `Deprecated` - Soon-to-be removed features
- `Removed` - Removed features
- `Fixed` - Bug fixes
- `Security` - Security improvements