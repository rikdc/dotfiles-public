set -l bw_sock "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"

if test -S "$bw_sock"
    set -gx SSH_AUTH_SOCK "$bw_sock"
end
