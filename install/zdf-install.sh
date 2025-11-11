#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL="$DOTFILES/"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Zero's Dotfiles Installation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

bash "$INSTALL/zdf-check.sh"

bash "$INSTALL/zdf-pkg-pacman.sh"
bash "$INSTALL/zdf-pkg-aur.sh"
bash "$INSTALL/zdf-link-config.sh"
bash "$INSTALL/zdf-link-bin.sh"
bash "$INSTALL/zdf-theme-init.sh"

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Installation complete"
echo "→ Reload shell or restart terminal"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

