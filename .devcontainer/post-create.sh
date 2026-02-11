#!/bin/bash

# Post-create script for VS Code devcontainer
# Installs Go development tools

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

echo "✓ All Go development tools installed successfully!"
