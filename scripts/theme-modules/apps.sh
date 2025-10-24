#!/bin/bash

# Apply Hyprland theme
apply_hyprland_theme() {
    local theme_path="$1"
    
    if [ -f "$theme_path/hyprland.conf" ]; then
        hyprctl reload
    fi
}

# Apply Kitty theme
apply_kitty_theme() {
    local theme_path="$1"
    
    if [ -f "$theme_path/kitty.conf" ]; then
        killall -SIGUSR1 kitty
    fi
}

# Apply Starship theme
apply_starship_theme() {
    local theme_path="$1"
    
    if [ -f "$theme_path/starship.toml" ]; then
        rm -f ~/.config/starship.toml
        ln -snf "$theme_path/starship.toml" ~/.config/starship.toml
    fi
}

# Apply Eza theme
apply_eza_theme() {
    local theme_path="$1"
    
    if [ -f "$theme_path/eza.yml" ]; then
        mkdir -p ~/.config/eza
        ln -snf "$theme_path/eza.yml" ~/.config/eza/theme.yml
    fi
}

# Apply Btop theme
apply_btop_theme() {
    local theme_path="$1"
    
    if [ -f "$theme_path/btop.theme" ]; then
        mkdir -p ~/.config/btop/themes
        ln -snf "$theme_path/btop.theme" ~/.config/btop/themes/current.theme
        pkill -SIGUSR2 btop
    fi
}

# Apply tmux theme
apply_tmux_theme() {
    local theme_path="$1"
    
    if [ -f "$theme_path/tmux.conf" ]; then
        tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null
        tmux refresh-client 2>/dev/null
    fi
}

# Apply Yazi theme
apply_yazi_theme() {
    local theme_path="$1"
    
    if [ -d "$theme_path/current.yazi" ]; then
        rm -rf ~/.config/yazi/flavors/current.yazi
        mkdir -p ~/.config/yazi/flavors
        ln -snf -r "$theme_path/current.yazi" ~/.config/yazi/flavors/current.yazi
    fi
}

# Apply all app themes
apply_all_themes() {
    local theme_path="$1"
    
    apply_hyprland_theme "$theme_path"
    apply_kitty_theme "$theme_path"
    apply_starship_theme "$theme_path"
    apply_eza_theme "$theme_path"
    apply_btop_theme "$theme_path"
    apply_tmux_theme "$theme_path"
    apply_yazi_theme "$theme_path"
}
