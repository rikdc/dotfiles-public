function ssh-agent-system --description "Switch to system SSH agent"
    set -e SSH_AUTH_SOCK
    echo "Switched to system SSH agent"
end
