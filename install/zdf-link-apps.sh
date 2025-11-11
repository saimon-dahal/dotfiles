
#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_APPS="$DOTFILES/applications"
TARGET_APPS="$HOME/.local/share/applications"
TARGET_ICONS="$HOME/.local/share/icons/hicolor/48x48/apps"

echo "→ Linking application files..."

mkdir -p "$TARGET_APPS"
mkdir -p "$TARGET_ICONS"

if [[ -d "$SOURCE_APPS/icons" ]]; then
    for icon in "$SOURCE_APPS/icons"/*.png; do
        [[ ! -f "$icon" ]] && continue
        name="$(basename "$icon")"
        dest="$TARGET_ICONS/$name"
        
        [[ -L "$dest" ]] && rm "$dest"
        [[ -e "$dest" ]] && rm "$dest"
        
        ln -sf "$icon" "$dest"
    done
fi

for desktop in "$SOURCE_APPS"/*.desktop; do
    [[ ! -f "$desktop" ]] && continue
    name="$(basename "$desktop")"
    dest="$TARGET_APPS/$name"
    
    [[ -L "$dest" ]] && rm "$dest"
    [[ -e "$dest" ]] && rm "$dest"
    
    ln -sf "$desktop" "$dest"
done

if [[ -d "$SOURCE_APPS/hidden" ]]; then
    for desktop in "$SOURCE_APPS/hidden"/*.desktop; do
        [[ ! -f "$desktop" ]] && continue
        name="$(basename "$desktop")"
        dest="$TARGET_APPS/$name"
        
        [[ -L "$dest" ]] && rm "$dest"
        [[ -e "$dest" ]] && rm "$dest"
        
        ln -sf "$desktop" "$dest"
    done
fi

if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" &>/dev/null || true
fi

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$TARGET_APPS" &>/dev/null || true
fi

echo "✓ Application files linked"
echo

