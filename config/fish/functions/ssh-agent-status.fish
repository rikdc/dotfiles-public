function ssh-agent-status --description "Show SSH agent status"
    echo "Current SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
    ssh-add -l 2>/dev/null; or echo "No SSH agent or no keys loaded"
end
