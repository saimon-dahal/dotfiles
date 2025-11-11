
# ═══════════════════════════════════════════
# zdf-link-bin.sh

#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES/bin"
TARGET="$HOME/.local/bin"

echo "→ Linking binaries..."

mkdir -p "$TARGET"

for item in "$SOURCE"/*; do
    [[ ! -f "$item" ]] && continue
    
    name="$(basename "$item")"
    dest="$TARGET/$name"
    
    [[ -L "$dest" ]] && rm "$dest"
    [[ -e "$dest" ]] && rm "$dest"
    
    chmod +x "$item"
    ln -sf "$item" "$dest"
done

if [[ ":$PATH:" != *":$TARGET:"* ]]; then
    echo "⚠ Add to shell config: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo "✓ Binaries linked"
echo

