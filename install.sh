#!/bin/bash
set -e

# Function to print a heading
print_section() {
    echo -e "\n\033[1;32m==> $1\033[0m"
}

print_section "Updating package lists"
sudo apt update

print_section "Installing essential packages (no recommends)"
sudo apt install --no-install-recommends -y \
    i3-wm \
    eza \
    zoxide \
    git \
    fonts-font-awesome \
    fonts-terminus \
    fonts-noto-color-emoji \
    unzip \
    curl \
    fzf \
    micro \
    shotcut

print_section "Removing nano and cleaning up"
sudo apt purge -y nano
sudo apt autoremove -y

print_section "Installing FiraCode Nerd Font"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -q FiraCode.zip
rm FiraCode.zip
fc-cache -fv > /dev/null

print_section "Setting up Micro as IDE"
mkdir -p ~/.config/micro
cat > ~/.config/micro/settings.json <<EOF
{
  "autosave": true,
  "colorscheme": "simple",
  "filetree": true,
  "softwrap": true,
  "ruler": true,
  "statusline": true,
  "tabsize": 4,
  "syntax": true,
  "linenumbers": "relative",
  "clipboard": "external",
  "pluginchannels": ["default"]
}
EOF

cat > ~/.config/micro/bindings.json <<EOF
{
  "Ctrl-o": "command:save",
  "Ctrl-x": "command:quit",
  "Ctrl-w": "command:find",
  "Ctrl-\\\\": "command:replace",
  "Ctrl-k": "command:cut",
  "Ctrl-u": "command:paste",
  "Ctrl-g": "command:help",
  "Ctrl-c": "command:cursorpos",
  "Ctrl-t": "command:togglecomment"
}
EOF

print_section "Installing Micro plugins"
micro -plugin install filemanager linter formatter comment snippets jump fzf autocomplete git || true

print_section "Copying QTerminal settings (if available)"
if [[ -f qterminal.ini && -f SoftTwilight.colorscheme ]]; then
    mkdir -p ~/.config/qterminal.org/color-schemes
    cp qterminal.ini ~/.config/qterminal.org/qterminal.ini
    cp SoftTwilight.colorscheme ~/.config/qterminal.org/color-schemes/SoftTwilight.colorscheme
    echo "✅ QTerminal config applied."
else
    echo "⚠️  QTerminal config files not found. Skipping."
fi

print_section "Installing Oh My Bash"
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

# Optional: Replace .bashrc if local version exists
if [[ -f .bashrc ]]; then
    cp .bashrc ~/.bashrc
    echo "✅ Custom .bashrc applied."
else
    echo "⚠️  .bashrc not found. Using default."
fi

print_section "Setup Complete"

# Prompt for reboot
read -p "Would you like to reboot now? (y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "You can reboot later with: sudo reboot"
fi
