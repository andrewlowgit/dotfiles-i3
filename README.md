# Andrew's Dotfiles

My personal configuration files for i3wm setup on CachyOS (Arch-based).

## What's Included

- **i3** - Window manager configuration with custom keybindings
- **Polybar** - Status bar with custom modules
- **Fish** - Shell configuration with aliases
- **Alacritty** - Terminal (using defaults)
- **Rofi** - Application launcher
- **Picom** - Compositor
- **Dunst** - Notification daemon
- **Flameshot** - Screenshot tool
- **X11** - Xmodmap for Capslock→Hyper key

## Quick Start (New Machine)

### 1. Install Required Packages
```bash
sudo pacman -S i3-wm polybar alacritty fish rofi picom dunst feh \
               redshift xob pamixer flameshot i3lock stow git \
               ttf-hack polkit-gnome dex
```

### 2. Clone and Deploy
```bash
# Clone this repo
git clone <your-repo-url> ~/dotfiles

# Stow all configs
cd ~/dotfiles
stow */
```

### 3. System-Level Configuration

See SYSTEM-SETUP.md for:
- Keyboard fnmode settings
- Display configuration
- Laptop-specific adjustments

### 4. Reload i3

Press Super+Shift+R to reload i3 with new config.

## Daily Workflow

### Syncing Changes

After editing configs:
```bash
dotsync  # Commits changes
git push # Pushes to remote
```

On other machine:
```bash
dotpull  # Pulls latest changes
```

### Important Notes

- Configs are symlinked via stow - editing them automatically updates dotfiles repo
- Remember to commit and push after making changes
- Pull before editing to avoid conflicts

## Key Bindings

- Super+Return - Open terminal
- Ctrl+Space - Application launcher (rofi)
- Super+Q - Close window
- Super+L - Lock screen
- Capslock+B - Open browser (hyper key)
- Print or Super+Shift+S - Screenshot

## Custom Features

- Hyper key: Capslock mapped as Mod3 for custom shortcuts
- Alice blue borders on focused windows
- Auto-start workspace 1 with terminal
