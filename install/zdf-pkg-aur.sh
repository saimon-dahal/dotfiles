# ═══════════════════════════════════════════
# zdf-pkg-aur.sh

#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKGLIST="$DOTFILES/pkglist-aur.txt"

install_paru() {
    echo "→ Installing paru..."
    
    if ! command -v rustup &> /dev/null; then
        sudo pacman -S --needed --noconfirm base-devel rustup
        rustup default stable
    fi
    
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd
    rm -rf "$TEMP_DIR"
    
    echo "✓ paru installed"
}

if ! command -v paru &> /dev/null && ! command -v yay &> /dev/null; then
    install_paru
fi

AUR_HELPER=$(command -v paru || command -v yay)

[[ ! -f "$PKGLIST" ]] && { echo "✗ pkglist-aur.txt not found"; exit 1; }

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
