if status is-interactive
    # Modern CLI replacements
    if command -q bat
        abbr --add cat bat
    end
    if command -q eza
        abbr --add ll "eza -la --git"
        abbr --add ls eza
    end
    if command -q lazygit
        abbr --add lg lazygit
    end

    # Unix improvements
    abbr --add mkdir "mkdir -p"
    abbr --add ln "ln -v"

    # IP utilities
    abbr --add ip "curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'"
    abbr --add localip "ipconfig getifaddr en0"

    # Path pretty print
    abbr --add path 'echo $PATH | tr " " "\n"'
end
