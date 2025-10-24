# Dotfiles

Personal configuration for Linux (Hyprland, Neovim, tmux, Zsh, and more) managed with GNU Stow. Includes scripts and theme support.

## ⚠️ Warning

Running the installer will **unstow/remove existing configs** for `base` and `scripts`. Back up anything important before proceeding.

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

1. Unstow any previous configs for `base`, `scripts`.
2. Stow fresh `base` and `scripts`.
3. Make all files in `~/.local/bin` executable.
4. Set up a `~/.config/themes/current` symlink (default: `everforest`).


## Directory Structure (Overview)

* `base/` – core dotfiles: Zsh, tmux, Neovim, kitty, btop, ripgrep, Yazi, hyprland, rofi, swaync, waybar
* `scripts/.local/bin/` – utility scripts (wallpaper, recording, notifications, themes)
* `themes/` – complete themes (Everforest, Catppuccin)
* `theme-modules/` – helper scripts for applying themes

This updates all supported apps’ configs (Neovim, Hyprland, kitty, etc.).

## Notes

* Scripts assume `~/.local/bin` is in `$PATH`.
* Stow manages symlinks; never edit files directly in your home directory.
