#!/usr/bin/env bash

# Install MCP servers for Claude Code (user scope)
# This script configures the MCP servers defined in mcp.json

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_CONFIG_FILE="$SCRIPT_DIR/mcp-servers.json"

echo "🔧 Installing MCP servers for Claude Code..."

# Check if Claude Code is available
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code CLI not found. Please install Claude Code first."
    echo "   Visit: https://docs.anthropic.com/en/docs/claude-code"
    exit 1
fi

# Check if MCP config file exists
if [[ ! -f "$MCP_CONFIG_FILE" ]]; then
    echo "❌ MCP configuration file not found: $MCP_CONFIG_FILE"
    exit 1
fi

echo "📋 Found MCP configuration file: $MCP_CONFIG_FILE"

# Install Context7 server
echo "🌐 Installing Context7 MCP server..."
claude mcp add --scope user --transport http context7 https://mcp.context7.com/mcp || {
    echo "⚠️  Failed to install Context7 server (may already exist)"
}

# Install Sequential Thinking server
echo "🧠 Installing Sequential Thinking MCP server..."
claude mcp add --scope user sequential-thinking npx @modelcontextprotocol/server-sequential-thinking || {
    echo "⚠️  Failed to install Sequential Thinking server (may already exist)"
}

echo "✅ MCP server installation complete!"
echo ""
echo "📝 To verify installation, run:"
echo "   claude mcp list"
echo ""
echo "🔍 To check server status:"
echo "   claude mcp get context7"
echo "   claude mcp get sequential-thinking"