
# ═══════════════════════════════════════════
# zdf-link-config.sh

#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES/config"
TARGET="$HOME/.config"

echo "→ Linking configuration files..."

mkdir -p "$TARGET"

for item in "$SOURCE"/*; do
    [[ ! -e "$item" ]] && continue
    
    name="$(basename "$item")"
    dest="$TARGET/$name"
    
    [[ -L "$dest" ]] && rm "$dest"
    [[ -e "$dest" ]] && rm -rf "$dest"
    
    ln -sf "$item" "$dest"
done

echo "✓ Configuration linked"
echo

