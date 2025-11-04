#!/bin/bash

apply_gtk_theme() {
    local theme_dir="$1"
    local gtk_config="$theme_dir/gtk-theme.conf"
    
    if [ ! -f "$gtk_config" ]; then
        echo "No GTK config found for this theme"
        return
    fi
    
    # Source the theme config
    source "$gtk_config"
    
    # GTK 3
    local gtk3_settings="$HOME/.config/gtk-3.0/settings.ini"
    mkdir -p "$HOME/.config/gtk-3.0"
    
    cat > "$gtk3_settings" << EOF
[Settings]
gtk-theme-name=$GTK_THEME
gtk-icon-theme-name=$ICON_THEME
gtk-font-name=$FONT_NAME
gtk-cursor-theme-name=${CURSOR_THEME:-Adwaita}
gtk-cursor-theme-size=${CURSOR_SIZE:-24}
gtk-application-prefer-dark-theme=1
gtk-enable-animations=true
EOF

    # GTK 4
    local gtk4_settings="$HOME/.config/gtk-4.0/settings.ini"
    mkdir -p "$HOME/.config/gtk-4.0"
    
    cat > "$gtk4_settings" << EOF
[Settings]
gtk-theme-name=$GTK_THEME
gtk-icon-theme-name=$ICON_THEME
gtk-font-name=$FONT_NAME
gtk-cursor-theme-name=${CURSOR_THEME:-Adwaita}
gtk-cursor-theme-size=${CURSOR_SIZE:-24}
gtk-application-prefer-dark-theme=1
gtk-enable-animations=true
EOF

    # Update gsettings for running applications
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface font-name "$FONT_NAME" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface cursor-theme "${CURSOR_THEME:-Adwaita}" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface cursor-size "${CURSOR_SIZE:-24}" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
}
