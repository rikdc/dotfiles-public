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
	cat ${DOTFILES}/vscode/extensions.txt | xargs -L 1 code --install-extension

# Save all current extensions to vscode/extensions.txt
vscode-save:
	code --list-extensions > ${DOTFILES}/config/vscode/extensions.txt
