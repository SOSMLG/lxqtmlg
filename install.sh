#!/bin/bash

set -e

echo "==> Updating package lists..."
sudo apt update

echo "==> Installing essential packages (no recommends)..."
sudo apt install --no-install-recommends -y \
    i3-wm \
    eza \
    zoxide \
    git \
    fonts-font-awesome \
    fonts-terminus \
    fonts-noto-color-emoji \
    unzip \
    curl

echo "==> Creating fonts directory..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

echo "==> Downloading FiraCode Nerd Font with curl..."
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

echo "==> Extracting font..."
unzip -q FiraCode.zip
rm FiraCode.zip

echo "==> Refreshing font cache..."
fc-cache -fv > /dev/null

echo "✅ Installation complete!"

echo ""
echo "📌 Final steps:"
