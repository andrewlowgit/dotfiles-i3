#!/bin/bash

set -e  # Exit on any error

echo "=========================================="
echo "Andrew's i3 Setup Script"
echo "=========================================="
echo ""

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
    echo "Error: This script requires an Arch-based system (pacman)"
    exit 1
fi

# 1. Handle dotfiles first
echo "[1/6] Checking for dotfiles directory..."

if [ -d ~/dotfiles ]; then
    echo ""
    echo "~/dotfiles directory already exists."
    echo ""
    echo "What would you like to do?"
    echo "  1) Update existing (git pull)"
    echo "  2) Remove and re-clone (fresh start)"
    echo "  3) Exit (handle manually)"
    echo ""
    read -p "Enter choice [1-3]: " choice
    
    case $choice in
        1)
            echo "Updating existing dotfiles..."
            cd ~/dotfiles
            if [ -d .git ]; then
                git pull
            else
                echo "ERROR: ~/dotfiles is not a git repository!"
                echo "Choose option 2 to remove and re-clone."
                exit 1
            fi
            ;;
        2)
            echo "Removing ~/dotfiles and cloning fresh..."
            cd ~
            rm -rf ~/dotfiles
            git clone https://github.com/andrewlowgit/dotfiles-i3.git ~/dotfiles
            cd ~/dotfiles
            ;;
        3)
            echo "Exiting. Please handle ~/dotfiles manually."
            exit 0
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
else
    echo "Cloning dotfiles repository..."
    git clone https://github.com/andrewlowgit/dotfiles-i3.git ~/dotfiles
    cd ~/dotfiles
fi

# 2. Install all required packages
echo ""
echo "[2/6] Installing required packages..."
if [ -f ~/dotfiles/packages/install-packages.sh ]; then
    bash ~/dotfiles/packages/install-packages.sh
else
    echo "ERROR: ~/dotfiles/packages/install-packages.sh not found!"
    exit 1
fi

# 3. Backup existing configs
echo ""
echo "[3/6] Backing up existing configs (if any)..."
timestamp=$(date +%Y%m%d_%H%M%S)
[ -d ~/.config/i3 ] && mv ~/.config/i3 ~/.config/i3.backup.$timestamp
[ -d ~/.config/polybar ] && mv ~/.config/polybar ~/.config/polybar.backup.$timestamp
[ -d ~/.config/fish ] && mv ~/.config/fish ~/.config/fish.backup.$timestamp
[ -d ~/.config/picom ] && mv ~/.config/picom ~/.config/picom.backup.$timestamp
[ -d ~/.config/dunst ] && mv ~/.config/dunst ~/.config/dunst.backup.$timestamp
[ -d ~/.config/rofi ] && mv ~/.config/rofi ~/.config/rofi.backup.$timestamp
[ -f ~/.xinitrc ] && mv ~/.xinitrc ~/.xinitrc.backup.$timestamp
[ -f ~/.xmodmap ] && mv ~/.xmodmap ~/.xmodmap.backup.$timestamp

# 4. Deploy configurations
echo ""
echo "[4/6] Deploying configurations with stow..."
cd ~/dotfiles
stow */

# 5. Make scripts executable
echo ""
echo "[5/6] Making scripts executable..."
chmod +x ~/.config/polybar/launch.sh

# 6. Set fish as default shell
echo ""
echo "[6/6] Setting fish as default shell..."
if [ "$SHELL" != "/usr/bin/fish" ]; then
    chsh -s /usr/bin/fish
    echo "Fish shell set as default (takes effect on next login)"
else
    echo "Fish already set as default shell"
fi

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Log out of your current session"
echo "2. At the login screen, select 'i3' as your session"
echo "3. Log in"
echo ""
echo "Or if at TTY, simply run: startx"
echo ""
echo "Key bindings:"
echo "  Super+Return    - Terminal"
echo "  Ctrl+Space      - App launcher"
echo "  Super+Shift+R   - Reload i3"
echo ""
if [ -f ~/.config/i3.backup.$timestamp ] || [ -f ~/.config/polybar.backup.$timestamp ]; then
    echo "Backups of old configs saved with .backup.$timestamp"
fi
