#!/usr/bin/env bash

WALLPAPERS="$HOME/Wallpapers/"
CURRENT_WALLPAPER=$(hyprctl hyprpaper listloaded)

WALLPAPER=$(find "$WALLPAPERS" -type f ! -name "$(basename "$CURRENT_WALLPAPER")" | shuf -n 1)

hyprctl hyprpaper reload ,"$WALLPAPER"
