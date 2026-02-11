# GoTour

## Development Environment

This repository is configured with VS Code Dev Containers for a consistent Go development environment.

### Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Getting Started

1. Clone this repository
2. Open the repository in VS Code
3. When prompted, click "Reopen in Container" (or run the command "Dev Containers: Reopen in Container")
4. Wait for the container to build and start

### What's Included

The devcontainer provides:

- **Go 1.23** (Debian Bookworm base)
- **Go Tools**: gopls, delve (debugger), staticcheck, golangci-lint
- **VS Code Extensions**:
  - Go extension for full language support
  - GitLens for Git integration
  - Markdown linting
  - Docker extension
- **Shell**: Zsh with Oh My Zsh
- **Auto-formatting**: Format on save with gofumpt
- **Auto-import**: Automatic import organization

### Development

The container is configured to automatically install Go development tools on first run. You can start coding immediately after the container is ready.