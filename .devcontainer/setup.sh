#!/bin/bash
set -e

echo "🚀 direnv Development Environment Setup"

# Go と CLI バージョン確認
echo "📦 Checking Go version..."
go version

echo "📦 Checking make version..."
make --version

# golangci-lint インストール
echo "📦 Installing golangci-lint..."
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin latest

# Murex インストール
echo "📦 Installing Murex shell..."
GOBIN="$(pwd)" go install -v github.com/lmorg/murex@latest
chmod +x murex
sudo mv murex /usr/local/bin/murex || true

# PowerShell インストール
echo "📦 Installing PowerShell..."
sudo apt-get update
sudo apt-get install -y libicu72
curl -L -o /tmp/pwsh.deb https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.5/powershell-preview_7.6.0-preview.5-1.deb_amd64.deb
sudo dpkg -i /tmp/pwsh.deb
sudo rm /tmp/pwsh.deb
sudo mv /usr/bin/pwsh-preview /usr/bin/pwsh

# その他シェル確認
echo "📦 Checking shells..."
fish --version || true
elvish -version || true
zsh --version || true
tcsh --version || true

# direnv テストコマンド確認
echo "✅ Setup complete!"
echo ""
echo "📋 Available commands:"
go version
golangci-lint --version
murex --version
pwsh --version
make --version