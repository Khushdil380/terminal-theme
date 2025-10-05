# Contributing to PowerShell Theme Framework

Thank you for your interest in contributing! This project welcomes contributions from the community.

## 🚀 Quick Start for Contributors

1. **Fork** the repository
2. **Clone** your fork locally
3. **Create** a feature branch (`git checkout -b feature/amazing-theme`)
4. **Make** your changes
5. **Test** thoroughly on different terminals
6. **Commit** your changes (`git commit -m 'Add amazing theme'`)
7. **Push** to your branch (`git push origin feature/amazing-theme`)
8. **Create** a Pull Request

## 🎨 Contributing Themes

### Creating a New Theme

1. Copy an existing theme from `themes/` directory
2. Rename it to your theme name (e.g., `my-awesome-theme.json`)
3. Modify the JSON configuration:
   ```json
   {
     "name": "My Awesome Theme",
     "description": "Brief description of your theme",
     "version": "1.0.0",
     "prompt_symbol": "symbol:chevron",
     "prompt_symbol_color": "#ffffff",
     "blocks": [ ... ]
   }
   ```
4. Test with `Set-PSTheme my-awesome-theme`
5. Take a screenshot for the preview

### Theme Design Guidelines

- **Readability**: Ensure text is readable in both light and dark terminals
- **Consistency**: Use consistent color schemes throughout blocks
- **Accessibility**: Consider users with color vision differences
- **Performance**: Avoid overly complex icons that might slow rendering
- **Compatibility**: Test on Windows Terminal, VS Code, and PowerShell ISE

## 🧩 Contributing Modules

### Creating New Block Modules

1. Create a new file in `modules/` directory (e.g., `battery.ps1`)
2. Implement the required function:
   ```powershell
   function Get-BatteryBlock {
       param(
           [object]$Config,
           [object]$ThemeConfig
       )
       
       # Your block logic here
       return @{
           Text = "Battery: 85%"
           Color = $Config.foreground
           BackgroundColor = $Config.background
       }
   }
   ```
3. Update theme files to include your new block
4. Test thoroughly

### Module Guidelines

- **Error Handling**: Always include proper error handling
- **Performance**: Keep modules lightweight and fast
- **Cross-platform**: Consider PowerShell Core compatibility when possible
- **Documentation**: Add clear comments explaining the module's purpose

## 🐛 Bug Reports

When reporting bugs, please include:

- **PowerShell Version**: `$PSVersionTable.PSVersion`
- **Operating System**: Windows version
- **Terminal**: Which terminal application you're using
- **Theme**: Which theme was active when the bug occurred
- **Steps to Reproduce**: Clear steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Screenshots**: If applicable

## 💡 Feature Requests

We welcome feature requests! Please:

1. **Check existing issues** to avoid duplicates
2. **Describe the use case** - why would this feature be useful?
3. **Provide examples** - show how you'd like it to work
4. **Consider implementation** - if you have ideas about how to implement it

## 📖 Documentation

Help improve documentation by:

- **Fixing typos** and grammar errors
- **Adding examples** for complex features
- **Creating tutorials** for common use cases
- **Improving clarity** of existing documentation
- **Adding screenshots** and visual aids

## 🧪 Testing

Before submitting a PR, please test:

- **Different PowerShell versions** (5.1, 7.0+)
- **Different terminals** (Windows Terminal, VS Code, PowerShell ISE)
- **Different scenarios** (with/without Git, long paths, admin mode)
- **Theme switching** between your theme and existing themes
- **Installation/uninstallation** process

## 📋 Code Style

- **Follow PowerShell best practices**
- **Use meaningful variable names**
- **Add comments for complex logic**
- **Maintain consistent indentation** (4 spaces)
- **Keep functions focused** on single responsibilities

## 🏷️ Versioning

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, backward compatible

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🤝 Code of Conduct

- **Be respectful** and inclusive
- **Provide constructive feedback**
- **Focus on the code**, not the person
- **Help others learn** and grow
- **Celebrate diversity** of ideas and approaches

## ❓ Questions?

- **Open an issue** for questions about contributing
- **Check existing documentation** in the `docs/` directory
- **Look at existing code** for examples and patterns

Thank you for making the PowerShell Theme Framework better! 🎉