# System-Level Setup Guide

This documents system configurations that cannot be stored in dotfiles and must be configured manually on each machine.

## Keyboard Configuration

### Apple Keyboard fnmode (if applicable)

Current setting on desktop: fnmode=2 (function keys work normally)

Check current setting:
```bash
cat /sys/module/hid_apple/parameters/fnmode
```

To make permanent, create `/etc/modprobe.d/hid_apple.conf`:
```bash
sudo nano /etc/modprobe.d/hid_apple.conf
```

Add this line:
```
options hid_apple fnmode=2
```

Regenerate initramfs:
```bash
sudo mkinitcpio -P
```

Reboot for changes to take effect.

## Display Configuration

### Desktop Setup

- Monitor: DisplayPort-0
- Resolution: 3840x2160 @ 60Hz
- Scaling: 1x1 (100%)

**Important:** i3 config line:
```
exec xrandr --output DisplayPort-0 --mode 3840x2160 --rate 60 --scale 1x1
```

### Laptop Setup (To Be Configured)

Check your laptop's display output:
```bash
xrandr
```

Common laptop outputs: `eDP-1`, `eDP`, or `LVDS-1`

Update i3 config line accordingly. For example:
```
exec xrandr --output eDP-1 --mode 1920x1080 --rate 60 --scale 1x1
```

**Tip:** You may want to use a separate branch or conditional logic for laptop-specific display settings.

## Laptop-Specific Considerations

### Battery Management
Consider installing:
```bash
sudo pacman -S tlp tlp-rdw
sudo systemctl enable --now tlp
```

### Backlight Control
Add yourself to video group:
```bash
sudo usermod -aG video $USER
```

Add keybindings to i3 config:
```
bindsym XF86MonBrightnessUp exec brightnessctl set +5%
bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
```

### Touchpad Settings
Install and configure libinput:
```bash
sudo pacman -S xf86-input-libinput
```

Create `/etc/X11/xorg.conf.d/30-touchpad.conf` for tap-to-click, etc.

### Power Management
Consider setting up:
- Lid close actions
- Power button behavior
- Suspend/hibernate configuration

## Required System Packages

Core packages (install first):
```bash
sudo pacman -S base-devel git stow
```

i3 ecosystem:
```bash
sudo pacman -S i3-wm i3lock polybar rofi dunst
```

Terminal and shell:
```bash
sudo pacman -S alacritty fish
```

Visual:
```bash
sudo pacman -S picom feh redshift
```

Tools:
```bash
sudo pacman -S flameshot pamixer xob
```

Fonts:
```bash
sudo pacman -S ttf-hack ttf-dejavu ttf-liberation noto-fonts
```

System:
```bash
sudo pacman -S polkit-gnome dex
```

## Post-Installation Checklist

After stowing dotfiles on a new machine:

- [ ] Install all required packages
- [ ] Configure display outputs in i3 config
- [ ] Set up keyboard fnmode (if needed)
- [ ] Test hyper key (Capslock) works via xmodmap
- [ ] Verify all keybindings work
- [ ] Check polybar displays correctly
- [ ] Test flameshot screenshots
- [ ] Configure laptop-specific settings (if applicable)
- [ ] Set up default browser
- [ ] Configure git identity

## Fish Shell Setup

Set fish as default shell:
```bash
chsh -s /usr/bin/fish
```

Logout and login for changes to take effect.

## Notes

- Desktop uses DisplayPort-0 for 4K monitor
- Laptop will need display output adjusted in i3 config
- Hyper key setup via xmodmap should work on both machines
- Remember to adjust display scaling based on screen DPI
