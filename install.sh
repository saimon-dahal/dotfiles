#!/bin/bash
set -euo pipefail
cd ~/dotfiles

echo "→ Unstowing old configs..."
stow -D base 2>/dev/null || true
stow -D hyprland 2>/dev/null || true
stow -D scripts 2>/dev/null || true   # full unstow so no stale symlinks
echo "✓"

echo "→ Stowing base..."
stow base
echo "✓"

echo "→ Stowing hyprland..."
stow hyprland
echo "✓"

echo "→ Stowing scripts..."
stow scripts
echo "✓"

echo "→ chmod +x bin..."
find ~/.local/bin -type f -exec chmod +x {} \;
echo "✓"

echo "→ Setting up themes symlink..."
mkdir -p ~/.config/themes
[[ ! -L ~/.config/themes/current ]] && \
    ln -sf ~/dotfiles/themes/everforest ~/.config/themes/current
echo "✓"

echo "✅ Done."
