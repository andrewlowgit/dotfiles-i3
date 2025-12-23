# Quick Reference Guide

## Daily Workflow

### After Making Config Changes
```bash
dotsync              # Commits changes (prompts for message)
git push             # Pushes to GitHub
```

### Getting Changes from Other Machine
```bash
dotpull              # Pulls latest from GitHub
# Changes apply immediately via symlinks
# Reload i3: Super+Shift+R
```

### Manual Git Operations
```bash
cd ~/dotfiles
git status           # See what changed
git log --oneline    # View commit history
git diff             # See exact changes
git add .            # Stage all changes
git commit -m "msg"  # Commit with message
git push             # Push to GitHub
git pull             # Pull from GitHub
```

## File Locations

### Actual Config Files (symlinked)
```
~/.config/i3/config          → ~/dotfiles/i3/.config/i3/config
~/.config/polybar/           → ~/dotfiles/polybar/.config/polybar/
~/.config/fish/              → ~/dotfiles/fish/.config/fish/
~/.xmodmap                   → ~/dotfiles/x11/.xmodmap
```

### Dotfiles Repository
```
~/dotfiles/                  # All your configs live here
```

## Stow Commands

### Apply configs (if needed)
```bash
cd ~/dotfiles
stow i3              # Stow single package
stow */              # Stow everything
```

### Remove symlinks
```bash
stow -D i3           # Unstow single package
stow -D */           # Unstow everything
```

### Re-stow (update symlinks)
```bash
stow -R i3           # Re-stow single package
```

## Key Bindings

### Window Management
- `Super+Return` - New terminal
- `Super+Q` - Close window
- `Super+Arrow` - Focus direction
- `Super+Shift+Arrow` - Move window
- `Super+H/V` - Split horizontal/vertical
- `Super+F` - Fullscreen
- `Super+S/W/E` - Stacking/Tabbed/Split layout

### Workspaces
- `Super+1-9` - Switch workspace
- `Super+Shift+1-9` - Move to workspace

### Applications
- `Ctrl+Space` - Rofi launcher
- `Capslock+B` - Browser (hyper key)
- `Super+L` - Lock screen
- `Print` or `Super+Shift+S` - Screenshot

### System
- `Super+Shift+R` - Reload i3
- `Super+Shift+E` - Exit i3

## Troubleshooting

### Config not updating?
```bash
# Check if symlink exists
ls -la ~/.config/i3/config

# Should show: ... -> dotfiles/i3/.config/i3/config

# If broken, re-stow
cd ~/dotfiles
stow -R i3
```

### Polybar not showing?
```bash
# Restart polybar
~/.config/polybar/launch.sh

# Or reload i3
Super+Shift+R
```

### Fish aliases not working?
```bash
# Reload fish config
source ~/.config/fish/config.fish

# Check if alias exists
type update
```

### Display issues after update?
```bash
# Check current display
xrandr

# Update i3 config if output name changed
nano ~/.config/i3/config
# Find line: exec xrandr --output ...
```

## Adding New Configs

### Add a new application config
```bash
# 1. Create package directory
mkdir -p ~/dotfiles/newapp/.config/newapp

# 2. Copy config
cp -r ~/.config/newapp/* ~/dotfiles/newapp/.config/newapp/

# 3. Backup original
mv ~/.config/newapp ~/.config/newapp.backup

# 4. Stow it
cd ~/dotfiles
stow newapp

# 5. Test and commit
dotsync
git push

# 6. Remove backup if working
rm -rf ~/.config/newapp.backup
```

## Useful Aliases

Current aliases (in ~/.config/fish/aliases.fish):
```
update               # sudo pacman -Syu
i3config             # nano ~/.config/i3/config
```

Add more by editing: `nano ~/.config/fish/aliases.fish`

## GitHub Repository

- URL: https://github.com/andrewlowgit/dotfiles-i3
- Clone command: `git clone https://github.com/andrewlowgit/dotfiles-i3.git ~/dotfiles`

## Emergency Recovery

### If you mess up configs badly:
```bash
# Revert last commit
cd ~/dotfiles
git revert HEAD
git push

# Or go back to specific commit
git log --oneline        # Find commit hash
git reset --hard abc123  # Use actual hash
git push --force         # Only if you're sure!
```

### Start fresh from GitHub:
```bash
# Backup current (just in case)
mv ~/dotfiles ~/dotfiles.broken

# Clone fresh copy
git clone https://github.com/andrewlowgit/dotfiles-i3.git ~/dotfiles
cd ~/dotfiles
stow */
```

## Remember

- Edit configs normally - symlinks handle the rest
- `dotsync` commits changes locally
- `git push` sends to GitHub
- `dotpull` gets changes from other machines
- Always `git pull` before editing if using multiple machines
