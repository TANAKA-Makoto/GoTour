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

# Install Japanese Go Tour
echo "Installing Japanese Go Tour (go-tour-jp)..."
go install github.com/atotto/go-tour-jp/gotour@latest

echo "✓ All Go development tools installed successfully!"
echo ""
echo "To start the Japanese Go Tour, run: gotour"
