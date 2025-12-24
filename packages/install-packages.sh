#!/bin/bash
# Package installation script for new Arch/CachyOS installations

echo "Installing packages from dotfiles..."

# Core system packages
CORE_PACKAGES=(
base-devel
git
stow
)

# i3 ecosystem
WM_PACKAGES=(
i3-wm
i3lock
polybar
rofi
dunst
)

# Terminal and shell
TERMINAL_PACKAGES=(
alacritty
fish
)

# Visual/Desktop
VISUAL_PACKAGES=(
picom
feh
redshift
)

# Tools
TOOLS_PACKAGES=(
flameshot
pamixer
xob
)

# Fonts
FONT_PACKAGES=(
ttf-hack
ttf-dejavu
ttf-liberation
noto-fonts
)

# System
SYSTEM_PACKAGES=(
polkit-gnome
dex
)

# Additional packages (auto-added by pkgadd)
# Sort these into categories periodically
ADDITIONAL_PACKAGES=(
    htop
vlc
pcmanfm
)

# Combine all packages
ALL_PACKAGES=(
"${CORE_PACKAGES[@]}"
"${WM_PACKAGES[@]}"
"${TERMINAL_PACKAGES[@]}"
"${VISUAL_PACKAGES[@]}"
"${TOOLS_PACKAGES[@]}"
"${FONT_PACKAGES[@]}"
"${SYSTEM_PACKAGES[@]}"
"${ADDITIONAL_PACKAGES[@]}"
)

# Install packages
echo "Installing ${#ALL_PACKAGES[@]} packages..."
sudo pacman -S --needed "${ALL_PACKAGES[@]}"

echo "✓ Package installation complete!"
echo ""
echo "Next steps:"
echo "1. cd ~/dotfiles"
echo "2. stow */"
echo "3. See SYSTEM-SETUP.md for additional configuration"
