
#!/bin/bash
IMG="$1"
hyprctl hyprpaper preload "$IMG"
hyprctl hyprpaper wallpaper ",$IMG"
