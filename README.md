# GoTour

日本語版 A Tour of Go のローカル実行環境

## Development Environment

This repository is configured with VS Code Dev Containers for a consistent Go development environment with the Japanese Go Tour pre-installed.

### Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Getting Started

1. Clone this repository
2. Open the repository in VS Code
3. When prompted, click "Reopen in Container" (or run the command "Dev Containers: Reopen in Container")
4. Wait for the container to build and start

### Running the Japanese Go Tour

Once the devcontainer is ready, you can start the Japanese Go Tour:

```bash
gotour
```

This will start a local web server. Open your browser and navigate to http://localhost:3999 to access the Japanese version of A Tour of Go. The tour runs locally on your machine, making it faster than the online version.

### What's Included

The devcontainer provides:

- **Go 1.23** (Debian Bookworm base)
- **Japanese Go Tour** (go-tour-jp) - Ready to run with `gotour` command
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

The container is configured to automatically install Go development tools and the Japanese Go Tour on first run. You can start coding and learning Go immediately after the container is ready.

### About the Japanese Go Tour

This environment includes the Japanese version of "A Tour of Go" (go-tour-jp), which allows you to:
- Learn Go programming in Japanese
- Run code examples locally for better performance
- Work offline after the initial setup

For more information about the Go Tour, visit: https://go-tour-jp.appspot.com/