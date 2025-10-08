#!/bin/bash

set -euo pipefail

# Set to your wallpapers directory
WALLPAPER_DIR="$HOME/Pictures/wallpapers/waifus"

OMA_CURRENT_BACKGROUND_LINK="$HOME/.config/omarchy/current/background"

echo "Selecting random wallpaper from $WALLPAPER_DIR"
image_path="$(fd . -e jpg -e png -e jpeg -e webp "$WALLPAPER_DIR" | shuf -n 1)"
echo "Selected wallpaper: $image_path"

# Set new background symlink on omarchy
if [[ -e "$OMA_CURRENT_BACKGROUND_LINK" ]]; then
    echo "Omarchy background link detected, updating..."
    ln -nsfv "$image_path" "$OMA_CURRENT_BACKGROUND_LINK"
else
    echo "Omarchy link not present, skipping link update."
fi

echo "Setting new wallpaper..."
hyprctl hyprpaper reload ,"$image_path"
echo "Wallpaper set to $image_path"

set +euo pipefail