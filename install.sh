#!/bin/sh
# Meshbrow CLI installer
# Usage: curl -sSL https://get.meshbrow.dev | sh
set -e

REPO="meshbrow-dev/meshbrow-backend"
BINARY="meshbrow"
INSTALL_DIR="/usr/local/bin"

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
    x86_64|amd64) ARCH="amd64" ;;
    arm64|aarch64) ARCH="arm64" ;;
    *) echo "Error: unsupported architecture: $ARCH"; exit 1 ;;
esac

case "$OS" in
    darwin|linux) ;;
    *) echo "Error: unsupported OS: $OS"; exit 1 ;;
esac

# Get latest version
echo "Fetching latest version..."
VERSION=$(curl -sSf "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$VERSION" ]; then
    echo "Error: could not determine latest version"
    exit 1
fi

echo "Installing meshbrow ${VERSION} (${OS}/${ARCH})..."

# Download
URL="https://github.com/${REPO}/releases/download/${VERSION}/${BINARY}_${VERSION#v}_${OS}_${ARCH}.tar.gz"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

curl -sSfL "$URL" -o "${TMP_DIR}/meshbrow.tar.gz"
tar -xzf "${TMP_DIR}/meshbrow.tar.gz" -C "$TMP_DIR"

# Install
if [ -w "$INSTALL_DIR" ]; then
    cp "${TMP_DIR}/${BINARY}" "${INSTALL_DIR}/${BINARY}"
else
    echo "Installing to ${INSTALL_DIR} (requires sudo)..."
    sudo cp "${TMP_DIR}/${BINARY}" "${INSTALL_DIR}/${BINARY}"
fi

chmod +x "${INSTALL_DIR}/${BINARY}"

echo ""
echo "✓ meshbrow ${VERSION} installed to ${INSTALL_DIR}/${BINARY}"
echo ""
echo "Get started:"
echo "  meshbrow auth login --key YOUR_API_KEY"
echo "  meshbrow sessions create --stealth max"
echo ""
echo "Documentation: https://docs.meshbrow.dev/guides/cli"
