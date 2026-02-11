# Changelog

All notable changes to this dotfiles configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Migrated shell from ZSH + Oh My ZSH to Fish shell
- Replaced ZSH aliases with Fish abbreviations and functions
- Replaced exa (deprecated) with eza in Brewfile and setup script
- Removed duplicate zoxide entry from Brewfile

### Removed
- `claude/` directory — settings and MCP config now managed via separate plugin repos
- Oh My ZSH framework and submodule
- ZSH configuration files (zshrc, zprofile, aliases, ssh-agent.zsh)

### Added
- Claude Code AI assistant configuration integration
- Claude Task Manager slash command for context isolation and focused task execution
- Comprehensive README.md with features, installation, and usage documentation
- CLAUDE.md file for AI assistant guidance
- This changelog file to track changes

### Changed
- Enhanced README.md from basic description to comprehensive documentation

### Attribution
- README.md improvements: Structure and content enhanced with Claude Code assistance
- Claude Task Manager: Adapted from [grahama1970](https://gist.github.com/grahama1970/44a9da6a3da6769132037f06966945c2)

---

## Template for Future Entries

### Added
- New features or functionality

### Changed  
- Changes to existing functionality

### Deprecated
- Features that will be removed in future versions

### Removed
- Features that have been removed

### Fixed
- Bug fixes

### Security
- Security-related changes

### Attribution
- Credit for inspiration, code snippets, or contributions from other sources
- Format: `Feature/Change: Inspired by [Author](link) or adapted from [Repository](link)`