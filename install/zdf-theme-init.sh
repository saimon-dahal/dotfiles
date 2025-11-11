
# ═══════════════════════════════════════════
# zdf-theme-init.sh

#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEME_DIR="$HOME/.config/themes"
CURRENT="$THEME_DIR/current"

echo "→ Setting up themes symlink..."

mkdir -p "$THEME_DIR"

if [[ ! -L "$CURRENT" ]]; then
    ln -sf "$DOTFILES/themes/Everforest" "$CURRENT"
    echo "✓ Default theme set: Everforest"
else
    echo "✓ Theme already configured"
fi

echo
