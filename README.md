# dotfiles-public

A modern, comprehensive dotfiles configuration for macOS development environments. This setup provides a complete development environment with modern CLI tools, language version management, and optimized shell configuration.

## Features

- **Modern CLI Tools**: Enhanced replacements for standard tools (eza, bat, ripgrep, lazygit)
- **Multi-Language Support**: Managed via asdf for Node.js, Python, Ruby, Go, Java, Terraform, kubectl
- **Enhanced Shell**: Fish shell with Starship prompt for beautiful, informative terminal experience
- **Development Focused**: Pre-configured for Git, VS Code, Docker, and cloud development
- **macOS Optimized**: Homebrew package management and system defaults configuration
- **Automated Installation**: One-command setup with dotbot

## What's Included

### Shell Configuration
- Fish shell with auto-sourced conf.d and functions
- Starship prompt with Git status, language versions, and system info
- Smart directory jumping with zoxide
- Environment management with direnv
- Fish abbreviations for modern CLI tools (expand inline before execution)

### Development Tools
- Git configuration with global gitignore
- VS Code settings, keybindings, and extension management
- Claude Code AI assistant configuration
- Language version management via asdf
- Docker and Kubernetes tools
- AWS CLI and cloud development tools

### macOS Integration
- Homebrew for package management
- System defaults optimization
- Essential apps via Homebrew Cask

## Installation

### Quick Setup
```bash
git clone git@github.com:rikdc/dotfiles-public.git .dotfiles --recursive
cd .dotfiles
make install
```

### Manual Steps
1. Clone the repository with submodules
2. Run the installer which will:
   - Install Homebrew and essential packages
   - Configure macOS system defaults
   - Create symlinks for all configuration files
   - Set up development directories

## Usage

### Common Commands
```bash
# Full installation
make install

# Link files only (no setup scripts)
make link

# Backup current system state
make backup

# Update Homebrew packages
make brew

# Manage VS Code extensions
make vscode-save    # Save current extensions
make vscode-install # Install from list

# Setup language environments
make asdf-setup     # Install asdf plugins
asdf install        # Install versions from .tool-versions
```

### Language Management
```bash
# Install and set global versions
asdf install nodejs latest
asdf global nodejs latest

asdf install python 3.11.0
asdf global python 3.11.0
```

## Customization

- **Local overrides**: Create `~/.config/fish/config.local.fish` for local customizations
- **VS Code**: Extensions are managed via `config/vscode/extensions.txt`
- **Packages**: Edit `config/macos/Brewfile` for Homebrew packages
- **Shell prompt**: Customize `config/starship.toml` for prompt appearance

## File Structure

```
├── claude/             # Claude Code AI assistant settings
├── config/
│   ├── asdf/           # Language version management
│   ├── fish/           # Fish shell configuration
│   │   ├── config.fish     # Main config (env vars, tool init)
│   │   ├── conf.d/         # Auto-sourced config fragments
│   │   └── functions/      # Lazy-loaded Fish functions
│   ├── git/            # Git configuration
│   ├── macos/          # macOS setup scripts and packages
│   ├── vscode/         # VS Code settings and extensions
│   └── starship.toml   # Modern prompt configuration
├── install.conf.yaml   # Dotbot configuration
├── Makefile           # Common tasks
└── install            # Installation script
```

## Requirements

- macOS (tested on recent versions)
- Git (for cloning and submodules)
- Internet connection (for Homebrew and package installation)

## Thanks

Inspired by and adapted from:

- [abieber](https://github.com/aaronbieber/dotfiles) - Original inspiration
- [Thoughtbot](https://github.com/thoughtbot/dotfiles) - General approach
- [mjfaga](https://github.com/mjfaga/dotfiles) - Introduction to [dotbot](https://github.com/anishathalye/dotbot)
- [denolfe](https://github.com/denolfe/dotfiles) - Homebrew setup patterns
- [mathiasbynens](https://github.com/mathiasbynens/dotfiles) - macOS defaults configuration
