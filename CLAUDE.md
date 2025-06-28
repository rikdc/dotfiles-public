# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Installation and Setup
- `make install` - Run the complete dotfiles installation using dotbot
- `./install` - Direct installation script (same as make install)
- `make link` - Install only symlinks without running setup scripts
- `make backup` - Create timestamped backup of current system state

### Package Management
- `make brew` - Update Brewfile with current Homebrew packages and clean unused ones
- `make vscode-install` - Install VS Code extensions from extensions.txt
- `make vscode-save` - Save current VS Code extensions to extensions.txt
- `make asdf-setup` - Install and configure asdf language plugins

### Development Environment
- `asdf install` - Install language versions specified in .tool-versions
- `asdf global <plugin> <version>` - Set global version for a language

## Repository Architecture

This is a personal dotfiles repository that uses **dotbot** for installation management and follows a modular configuration approach:

### Core Structure
- `install.conf.yaml` - Dotbot configuration defining symlinks, shell commands, and cleanup
- `Makefile` - Common development tasks and shortcuts
- `config/` - All configuration files organized by tool/category

### Configuration Organization
- `config/git/` - Git configuration and global gitignore
- `config/zsh/` - Zsh shell configuration including oh-my-zsh integration
- `config/vscode/` - VS Code settings, keybindings, and extensions list
- `config/macos/` - macOS-specific setup scripts and Homebrew packages
- `config/asdf/` - Language version management setup
- `config/starship.toml` - Modern shell prompt configuration

### Claude Code Integration
- `.claude/` - Local repository-specific Claude Code configuration
- `claude/` - Global Claude Code commands and settings for installation (symlinked to user's global claude directory)
  - `claude/commands/` - Custom slash commands including task-manager and create-prd
  - `claude/settings.json` - Claude Code settings with telemetry disabled

### Installation Flow
1. Dotbot updates git submodules recursively
2. Runs macOS setup scripts (Homebrew installation, system defaults)
3. Creates symlinks for all configuration files
4. Sets up directory structure for vim and other tools

### Key Features
- **Modern CLI Tools**: Replaces traditional tools (ls→exa, cat→bat, z for directory jumping)
- **Multi-Language Support**: asdf for managing Node.js, Python, Ruby, Go, Java, Terraform, kubectl
- **Development Focused**: Includes tools like lazygit, ripgrep, fzf, docker, gh CLI
- **macOS Integration**: Specific optimizations and app installations via Homebrew

### Environment Variables
- `DOTFILES` - Points to installation directory (~/.dotfiles)
- Uses oh-my-zsh with "intheloop" theme, enhanced by Starship prompt
- Includes direnv and zoxide initialization for enhanced shell experience

### Aliases and Tools
The repository includes comprehensive aliases in `config/zsh/aliases` with modern CLI replacements and includes a specific Claude Code AI assistant alias with AWS Bedrock configuration.

## Security Guidelines

**CRITICAL**: Always follow security best practices when working with this repository:

### Secrets and Credentials
- **NEVER commit passwords, API keys, tokens, or any sensitive credentials**
- **ALWAYS scan files before committing for exposed secrets**
- Use environment variables or local configuration files for sensitive data
- Database connections, API endpoints, and authentication should use placeholder values or be empty in committed files

### Before Every Commit
1. Review all changes for sensitive information
2. Check VS Code settings, configuration files, and any new additions
3. Use `.gitignore` patterns for files containing secrets
4. Consider using tools like `git-secrets` or similar scanners

### Safe Configuration Patterns
- Database connections: Use empty arrays or placeholder configurations
- API keys: Reference environment variables (e.g., `${API_KEY}`)
- Passwords: Never hardcode, always use secure credential management
- Personal information: Keep in `.local` files that are not committed

This repository should serve as a template that others can safely use without exposing personal credentials or sensitive configuration.