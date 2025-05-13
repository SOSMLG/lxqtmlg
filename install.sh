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
    fzf \
    micro \
    shotcut
    
sudo apt purge nano 
sudo apt autoremove

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

#!/bin/bash

echo "🚀 Setting up Micro as an IDE on Debian..."

echo "📦 Installing dependencies..."
sudo apt update
sudo apt install -y git curl fzf ripgrep xclip build-essential
mkdir -p ~/.config/micro
echo "⚙️  Writing settings.json..."
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
echo "🛠️  Setting Ctrl+P for FZF..."
cat > ~/.config/micro/bindings.json <<EOF
{
  "Ctrl-o": "command:save",         // Write Out (Save)
  "Ctrl-x": "command:quit",         // Exit
  "Ctrl-w": "command:find",         // Where Is (Search)
  "Ctrl-\\": "command:replace",     // Replace
  "Ctrl-k": "command:cut",          // Cut Text
  "Ctrl-u": "command:paste",        // Uncut (Paste)
  "Ctrl-g": "command:help",         // Help
  "Ctrl-c": "command:cursorpos",    // Show Cursor Position
  "Ctrl-t": "command:togglecomment" // Optional: Toggle comment
}
EOF

# 6. Install plugins
echo "🔌 Installing plugins..."
micro -plugin install filemanager linter formatter comment snippets jump fzf autocomplete git

echo "✅ Done! Launch Micro and press Ctrl+P to fuzzy open files."

echo" Copying Qterminal And Color Scheme :D "
mkdir ~/.config/qterminal.org/color-schemes
cp qterminal.ini ~/.config/qterminal.org/qterminal.ini
cp SoftTwilight.colorscheme ~/.config/qterminal.org/color-schemes/SoftTwilight.colorscheme

echo "Clean Terminal Installed :D"
echo "Installing Oh My Bash"
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
cp .bashrc ~/.bashrc
echo "Everything is Ready Time To reboot"
sudo reboot
