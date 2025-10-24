# Dotfiles

Personal configuration for Linux (Hyprland, Neovim, tmux, Zsh, and more) managed with GNU Stow. Includes scripts and theme support.

## ⚠️ Warning

Running the installer will **unstow/remove existing configs** for `base`, `hyprland`, and `scripts`. Back up anything important before proceeding.

## Requirements

* GNU Stow
* Zsh
* Hyprland
* Neovim, tmux, kitty, and other standard tools as per `base` configs

## Installation

Clone the repo, then run:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:

1. Unstow any previous configs for `base`, `hyprland`, `scripts`.
2. Stow fresh `base`, `hyprland`, and `scripts`.
3. Make all files in `~/.local/bin` executable.
4. Set up a `~/.config/themes/current` symlink (default: `everforest`).

Optional configs are available under `optional/` and are not installed by default.

## Directory Structure (Overview)

* `base/` – core dotfiles: Zsh, tmux, Neovim, kitty, btop, ripgrep, Yazi
* `hyprland/` – Hyprland config, Waybar, Rofi, SwayNC
* `scripts/.local/bin/` – utility scripts (wallpaper, recording, notifications, themes)
* `themes/` – complete themes (Everforest, Catppuccin)
* `theme-modules/` – helper scripts for applying themes
* `optional/` – configs for optional tools

This updates all supported apps’ configs (Neovim, Hyprland, kitty, etc.).

## Notes

* Scripts assume `~/.local/bin` is in `$PATH`.
* Stow manages symlinks; never edit files directly in your home directory.
* Optional configs are separate and can be manually stowed if needed.
