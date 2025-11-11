
# ═══════════════════════════════════════════
# zdf-pkg-pacman.sh

#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKGLIST="$DOTFILES/pkglist-pacman.txt"

[[ ! -f "$PKGLIST" ]] && { echo "✗ pkglist-pacman.txt not found"; exit 1; }

echo "→ Installing pacman packages..."

installed=$(pacman -Qq)
to_install=()

while IFS= read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    echo "$installed" | grep -qx "$pkg" || to_install+=("$pkg")
done < "$PKGLIST"

if [[ ${#to_install[@]} -gt 0 ]]; then
    echo "Installing: ${to_install[*]}"
    sudo pacman -S --needed --noconfirm "${to_install[@]}"
else
    echo "All packages already installed"
fi

echo "✓ Pacman packages ready"
echo

