
# ═══════════════════════════════════════════
# zdf-pkg-aur.sh

#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKGLIST="$DOTFILES/pkglist-aur.txt"

[[ ! -f "$PKGLIST" ]] && { echo "✗ pkglist-aur.txt not found"; exit 1; }

if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "✗ AUR helper (yay/paru) not found"
    exit 1
fi

AUR_HELPER=$(command -v yay || command -v paru)

echo "→ Installing AUR packages..."

installed=$($AUR_HELPER -Qq)
to_install=()

while IFS= read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    echo "$installed" | grep -qx "$pkg" || to_install+=("$pkg")
done < "$PKGLIST"

if [[ ${#to_install[@]} -gt 0 ]]; then
    echo "Installing: ${to_install[*]}"
    $AUR_HELPER -S --needed --noconfirm "${to_install[@]}"
else
    echo "All AUR packages already installed"
fi

echo "✓ AUR packages ready"
echo

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
