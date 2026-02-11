#!/bin/bash

# Post-create script for VS Code devcontainer
# Installs Go development tools and Japanese Go Tour
#
# Why use post-create script instead of Dockerfile?
# 1. Leverages official Microsoft devcontainer images (maintained and secure)
# 2. Installs latest versions of tools automatically (@latest)
# 3. Easier to maintain and modify than Dockerfile
# 4. Tools installed in user space, keeping base image lightweight
# 5. No need to rebuild container image when updating tools
#
# See README.md for detailed explanation.

set -e  # Exit on error

echo "Installing Go development tools..."

# Display Go version
go version

# Install Go language server
echo "Installing gopls..."
go install golang.org/x/tools/gopls@latest

# Install Delve debugger
echo "Installing delve debugger..."
go install github.com/go-delve/delve/cmd/dlv@latest

# Install staticcheck
echo "Installing staticcheck..."
go install honnef.co/go/tools/cmd/staticcheck@latest

# Install golangci-lint
echo "Installing golangci-lint..."
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Clone Japanese Go Tour repository
echo "Cloning Japanese Go Tour (go-tour-jp)..."
TOUR_DIR="$HOME/go-tour-jp"
if [ ! -d "$TOUR_DIR" ]; then
    git clone https://github.com/atotto/go-tour-jp.git "$TOUR_DIR"
    echo "✓ Japanese Go Tour cloned to $TOUR_DIR"
else
    echo "✓ Japanese Go Tour already exists at $TOUR_DIR"
fi

# Create a convenience script to run the tour
echo "Creating gotour command..."
mkdir -p "$HOME/bin"
cat > "$HOME/bin/gotour" << 'EOF'
#!/bin/bash
cd "$HOME/go-tour-jp"
echo "Starting Japanese Go Tour..."
echo "The tour server will start at http://localhost:3999"
echo "Please open this URL in your browser to access the tour"
echo "Press Ctrl+C to stop the server"
go run .
EOF
chmod +x "$HOME/bin/gotour"

# Add ~/bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    # Only add to .zshrc if zsh is installed and the config file exists
    if command -v zsh &> /dev/null && [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
    fi
    # Export for current session
    export PATH="$HOME/bin:$PATH"
fi

echo "✓ All Go development tools installed successfully!"
echo ""
echo "To start the Japanese Go Tour, run: gotour"
