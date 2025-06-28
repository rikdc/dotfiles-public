# Declare phony targets (commands, not files)
.PHONY: install link brew vscode-install vscode-save backup asdf-setup mcp-setup

# Run dotbot install script
install:
	./install

link:
	./install --only link

# Save snapshot of all Homebrew packages to macos/Brewfile
brew:
	brew bundle dump -f --file=config/macos/Brewfile
	brew bundle --force cleanup --file=config/macos/Brewfile

# Install extensions from vscode/extensions.txt
vscode-install:
	cat ${DOTFILES}/config/vscode/extensions.txt | xargs -L 1 code --install-extension

# Save all current extensions to vscode/extensions.txt
vscode-save:
	code --list-extensions > ${DOTFILES}/config/vscode/extensions.txt

# Create backup of current system state
backup:
	@echo "Creating system state backup..."
	@mkdir -p backups/$(shell date +%Y%m%d_%H%M%S)
	@BACKUP_DIR=backups/$(shell date +%Y%m%d_%H%M%S) && \
	brew bundle dump --force --file=$$BACKUP_DIR/Brewfile.backup && \
	code --list-extensions > $$BACKUP_DIR/vscode-extensions.backup && \
	cp ~/.zshrc $$BACKUP_DIR/zshrc.backup 2>/dev/null || true && \
	cp ~/.gitconfig $$BACKUP_DIR/gitconfig.backup 2>/dev/null || true && \
	echo "Backup created in $$BACKUP_DIR"

# Setup asdf language plugins
asdf-setup:
	./config/asdf/setup-asdf.sh

# Setup MCP servers for Claude Code
mcp-setup:
	./claude/install-mcp.sh
