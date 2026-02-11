# DevContainer 設計ドキュメント / DevContainer Design Document

## 日本語 / Japanese

### なぜ Dockerfile ではなく post-create script を使用するのか？

このプロジェクトでは、Go 開発ツールのインストールに `postCreateCommand` を使用する post-create script (`post-create.sh`) を採用しています。Dockerfile を作成する代わりにこのアプローチを選択した理由は以下の通りです：

#### 1. **公式イメージの活用**
- Microsoft 公式の devcontainer イメージ (`mcr.microsoft.com/devcontainers/go:1-1.23-bookworm`) を直接使用
- 公式イメージは定期的に更新され、セキュリティパッチが適用される
- Go のバージョンアップが簡単（image タグを変更するだけ）

#### 2. **ビルド時間の短縮**
- Go ツールは `go install` で最新版がインストールされる
- これらのツールはユーザーディレクトリ (`$GOPATH/bin`) にインストールされる
- コンテナイメージの再ビルドが不要で、初回起動時のみインストール

#### 3. **保守性の向上**
- post-create.sh は読みやすく、編集が容易
- Dockerfile の複雑な RUN 命令や layer 最適化を気にする必要がない
- ツールの追加・削除が簡単

#### 4. **開発ツールの最新版を自動取得**
- `@latest` タグにより、常に最新の安定版がインストールされる
- Dockerfile で特定バージョンを固定すると、定期的な更新が必要

#### 5. **コンテナイメージのサイズ削減**
- 開発ツールはユーザー領域にインストールされる
- ベースイメージは軽量なまま保たれる

### いつ Dockerfile を使用すべきか？

以下の場合は Dockerfile の使用を検討してください：

- システムレベルのパッケージが必要な場合（apt-get install など）
- 特定バージョンの Go ツールを固定したい場合
- イメージの再現性を完全に保証したい場合
- チーム全体で完全に同一の環境が必要な場合

---

## English

### Why Use Post-Create Script Instead of Dockerfile?

This project uses a post-create script (`post-create.sh`) with `postCreateCommand` for installing Go development tools. Here are the reasons for choosing this approach over creating a custom Dockerfile:

#### 1. **Leverage Official Images**
- Directly uses Microsoft's official devcontainer image (`mcr.microsoft.com/devcontainers/go:1-1.23-bookworm`)
- Official images are regularly updated with security patches
- Easy Go version upgrades (just change the image tag)

#### 2. **Faster Build Times**
- Go tools are installed via `go install` with latest versions
- Tools are installed in user directory (`$GOPATH/bin`)
- No need to rebuild container images; installation happens only on first run

#### 3. **Better Maintainability**
- `post-create.sh` is easy to read and edit
- No need to worry about complex Dockerfile RUN commands or layer optimization
- Simple to add or remove tools

#### 4. **Automatic Latest Versions**
- `@latest` tag ensures the latest stable versions are always installed
- Pinning specific versions in Dockerfile requires regular manual updates

#### 5. **Smaller Container Images**
- Development tools are installed in user space
- Base image remains lightweight

### When Should You Use a Dockerfile?

Consider using a custom Dockerfile when:

- System-level packages are needed (via apt-get install, etc.)
- You want to pin specific versions of Go tools
- Complete reproducibility is required
- The entire team needs an identical environment

---

## Current Setup

### Files

- **`devcontainer.json`**: Main configuration file
  - Specifies base image
  - Configures VS Code settings and extensions
  - References post-create script

- **`post-create.sh`**: Installation script
  - Installs Go development tools:
    - `gopls` (language server)
    - `delve` (debugger)
    - `staticcheck` (static analyzer)
    - `golangci-lint` (linter)

### Benefits of This Architecture

✅ **Simplicity**: Easy to understand and modify  
✅ **Flexibility**: Quick tool updates without rebuilding  
✅ **Official Support**: Uses Microsoft-maintained base images  
✅ **Latest Tools**: Always get the newest versions  
✅ **Fast Startup**: Minimal first-time setup

### Trade-offs

⚠️ **Reproducibility**: Tool versions may vary between installations  
⚠️ **Network Dependency**: Requires internet access on first run  
⚠️ **Installation Time**: Takes a few minutes on first container creation

---

## Alternatives Considered

### Option 1: Custom Dockerfile (Not Chosen)

```dockerfile
FROM mcr.microsoft.com/devcontainers/go:1-1.23-bookworm

RUN go install golang.org/x/tools/gopls@latest && \
    go install github.com/go-delve/delve/cmd/dlv@latest && \
    go install honnef.co/go/tools/cmd/staticcheck@latest && \
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

**Pros**: More reproducible, no runtime installation  
**Cons**: Larger image, slower builds, harder to maintain

### Option 2: Use Features (Not Chosen)

Dev Container features could be used, but:
- Go tools don't have official features yet
- Custom features add complexity
- post-create script is more straightforward

### Option 3: Current Approach (✅ Chosen)

Post-create script with official base image:
- **Best balance** of simplicity, maintainability, and functionality
- **Recommended** by VS Code devcontainer best practices for user-space tools
- **Ideal** for this project's needs
