function ssh-agent-bitwarden --description "Switch to BitWarden SSH agent"
    set -gx SSH_AUTH_SOCK "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
    echo "Switched to BitWarden SSH agent"
end
