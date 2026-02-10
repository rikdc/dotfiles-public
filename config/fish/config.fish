set -gx DOTFILES $HOME/.dotfiles
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# Starship prompt
starship init fish | source

# Smart directory jumping
zoxide init --cmd cd fish | source

# Environment management
direnv hook fish | source

# Local overrides
test -f ~/.config/fish/config.local.fish; and source ~/.config/fish/config.local.fish
