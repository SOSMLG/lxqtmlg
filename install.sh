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
#!/bin/bash

# Set file name and path
SCHEME_NAME="SoftTwilight"
SCHEME_FILE="$HOME/.local/share/qtermwidget5/color-schemes/${SCHEME_NAME}.colorscheme"

# Ensure directory exists
mkdir -p "$(dirname "$SCHEME_FILE")"

# Write the color scheme
cat << EOF > "$SCHEME_FILE"
[General]
name=$SCHEME_NAME
background=#1F1B24
foreground=#F0ECEB
color0=#2B2235
color1=#E6A1CB
color2=#8CDDD5
color3=#C09BD5
color4=#A9C4E2
color5=#7B69A1
color6=#A49BAA
color7=#F0ECEB
color8=#3A2F47
color9=#FFA7C4
color10=#AEEAE4
color11=#E5C9F0
color12=#BED8F1
color13=#AD9CCB
color14=#D5C8E6
color15=#FFFFFF
EOF

# Notify user
echo "✅ SoftTwilight color scheme installed for QTerminal."
echo "➡ Open QTerminal → Preferences → Appearance → Select 'SoftTwilight'"
