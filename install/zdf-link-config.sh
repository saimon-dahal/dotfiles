#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_SOURCE="$DOTFILES/config"
CONFIG_TARGET="$HOME/.config"

echo "→ Linking config directories to $CONFIG_TARGET..."

mkdir -p "$CONFIG_TARGET"

# Link only directories
for item in "$CONFIG_SOURCE"/*; do
    [[ ! -d "$item" ]] && continue  # skip non-directories
    name="$(basename "$item")"
    dest="$CONFIG_TARGET/$name"

    [[ -L "$dest" ]] && rm "$dest"
    [[ -e "$dest" ]] && rm -rf "$dest"

    ln -sf "$item" "$dest"
    echo "Linked directory: $item → $dest"
done

# Link dotfiles explicitly
for file in .tmux.conf .zshrc; do
    src="$CONFIG_SOURCE/$file"
    dest="$HOME/$file"

    if [[ -e "$src" ]]; then
        [[ -L "$dest" ]] && rm "$dest"
        [[ -e "$dest" ]] && rm -rf "$dest"
        ln -sf "$src" "$dest"
        echo "Linked file: $src → $dest"
    fi
done

echo "✓ All configuration linked"
