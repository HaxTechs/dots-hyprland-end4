#!/bin/bash

WALLPAPER_PATH="$1"

# Prompt user with notify-send
ACTION=$(notify-send "Set as SDDM wallpaper?" "Do you want to set this wallpaper as the SDDM login background?" \
    -A "yes=Yes" \
    -A "no=No" \
    -a "Wallpaper Switcher")

if [ "$ACTION" = "yes" ]; then
    # Copy wallpaper to SDDM theme directory (requires sudo)
    sudo cp "$WALLPAPER_PATH" /usr/share/sddm/themes/SilentSDDM/backgrounds/default.jpg
    notify-send "SDDM Wallpaper Updated" "Wallpaper has been set as SDDM background." -a "Wallpaper Switcher"
fi