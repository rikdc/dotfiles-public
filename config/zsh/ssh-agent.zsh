# SSH Agent Configuration
# Configures SSH agent to use BitWarden or fallback to system agent

# BitWarden SSH Agent Configuration
BITWARDEN_SSH_SOCKET="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"

# Function to setup SSH agent
setup_ssh_agent() {
    # Check if BitWarden SSH agent socket exists and is accessible
    if [[ -S "$BITWARDEN_SSH_SOCKET" ]]; then
        export SSH_AUTH_SOCK="$BITWARDEN_SSH_SOCKET"
        echo "✓ Using BitWarden SSH agent"
        
        # Verify agent is working
        if ssh-add -l >/dev/null 2>&1; then
            echo "✓ BitWarden SSH agent is working"
        else
            echo "⚠ BitWarden SSH agent socket exists but not responding"
            echo "  Make sure BitWarden desktop is running with SSH agent enabled"
        fi
    else
        echo "ℹ BitWarden SSH agent not available, using system SSH agent"
        echo "  To use BitWarden SSH agent:"
        echo "  1. Open BitWarden desktop application"
        echo "  2. Go to Settings → Security → SSH Agent"
        echo "  3. Enable 'Enable SSH Agent'"
        # Keep system SSH agent (don't modify SSH_AUTH_SOCK)
    fi
}

# Setup SSH agent if this script is sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]] || [[ "${(%):-%N}" != "${0}" ]]; then
    setup_ssh_agent
fi

# Alias to manually switch SSH agents
alias ssh-agent-bitwarden='export SSH_AUTH_SOCK="$BITWARDEN_SSH_SOCKET" && echo "Switched to BitWarden SSH agent"'
alias ssh-agent-system='unset SSH_AUTH_SOCK && echo "Switched to system SSH agent"'
alias ssh-agent-status='echo "Current SSH_AUTH_SOCK: $SSH_AUTH_SOCK" && ssh-add -l 2>/dev/null || echo "No SSH agent or no keys loaded"'