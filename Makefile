# Run dotbot install script
install:
	./install

link:
	./install --only link

# Save snapshot of all Homebrew packages to macos/Brewfile
brew:
	brew bundle dump -f --file=config/macos/Brewfile
	brew bundle --force cleanup --file=config/macos/Brewfile