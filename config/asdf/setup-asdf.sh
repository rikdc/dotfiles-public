#!/usr/bin/env bash
# asdf Setup Script
# Installs and configures common programming language plugins for asdf

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if asdf is installed
if ! command -v asdf &> /dev/null; then
    print_error "asdf is not installed. Please install asdf first:"
    echo "  brew install asdf"
    echo "  Then restart your shell and run this script again."
    exit 1
fi

print_status "Starting asdf language plugin setup..."

# Install build dependencies for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_status "Installing build dependencies for macOS..."
    if command -v brew &> /dev/null; then
        # Dependencies for Python and Ruby compilation
        brew list openssl &> /dev/null || brew install openssl
        brew list readline &> /dev/null || brew install readline
        brew list sqlite3 &> /dev/null || brew install sqlite3
        brew list xz &> /dev/null || brew install xz
        brew list zlib &> /dev/null || brew install zlib
        print_success "Build dependencies installed"
    else
        print_warning "Homebrew not found. Some language builds may fail."
    fi
fi

# Function to install plugin if not already installed
install_plugin() {
    local plugin_name=$1
    local repo_url=$2
    
    if asdf plugin list | grep -q "^${plugin_name}$"; then
        print_warning "Plugin ${plugin_name} already installed"
    else
        print_status "Installing ${plugin_name} plugin..."
        if [ -n "$repo_url" ]; then
            asdf plugin add "$plugin_name" "$repo_url"
        else
            asdf plugin add "$plugin_name"
        fi
        print_success "Plugin ${plugin_name} installed"
    fi
}

# Install Node.js plugin
print_status "Setting up Node.js..."
install_plugin "nodejs"

# Import Node.js release team's OpenPGP keys for verification
if [[ ! -f ~/.gnupg/pubring.kbx ]] || ! gpg --list-keys | grep -q "Node.js"; then
    print_status "Importing Node.js GPG keys..."
    bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring' || true
fi

# Install Python plugin
print_status "Setting up Python..."
install_plugin "python"

# Install Ruby plugin
print_status "Setting up Ruby..."
install_plugin "ruby"

# Install Go plugin (check for conflicts with system Go)
if command -v go &> /dev/null && [[ $(which go) != *".asdf"* ]]; then
    print_warning "System Go installation detected at $(which go)"
    read -p "Do you want to manage Go with asdf instead? This may require PATH adjustments. (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Setting up Go..."
        install_plugin "golang" "https://github.com/kennyp/asdf-golang.git"
    else
        print_status "Skipping Go plugin installation"
    fi
else
    print_status "Setting up Go..."
    install_plugin "golang" "https://github.com/kennyp/asdf-golang.git"
fi

# Install Java plugin
print_status "Setting up Java..."
install_plugin "java"

# Install additional development tools
print_status "Setting up development tools..."

# Terraform
install_plugin "terraform"

# kubectl
install_plugin "kubectl"

# Docker Compose
install_plugin "docker-compose"

# Yarn (if not already available via Node.js)
install_plugin "yarn"

# Check for existing .tool-versions file
if [[ -f .tool-versions ]]; then
    print_warning "Found existing .tool-versions file. You may want to install the specified versions:"
    echo "  asdf install"
else
    print_status "No .tool-versions file found. You can create one with preferred versions:"
    echo "  Example commands:"
    echo "    asdf install nodejs latest"
    echo "    asdf global nodejs latest"
    echo "    asdf install python latest"
    echo "    asdf global python latest"
fi

print_success "asdf setup completed!"
print_status "Installed plugins:"
asdf plugin list

print_status "Next steps:"
echo "1. Install language versions: asdf install <plugin> <version>"
echo "2. Set global versions: asdf global <plugin> <version>"
echo "3. Or create .tool-versions files in your projects"
echo "4. Run 'asdf list all <plugin>' to see available versions"
echo ""
print_status "Example workflow:"
echo "  asdf install nodejs latest"
echo "  asdf install python 3.11.0"
echo "  asdf global nodejs latest"
echo "  asdf global python 3.11.0"