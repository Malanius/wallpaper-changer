#!/bin/bash
# omarchy uses swaybg and has fd installed by default

# Set to your wallpapers directory
WALLPAPER_DIR=~/Pictures/wallpapers/waifus
echo "Selecting random wallpaper from $WALLPAPER_DIR"
image_path="$(fd . -e jpg -e png -e jpeg -e webp "$WALLPAPER_DIR" | shuf -n 1)"
echo "Selected wallpaper: $image_path"

pkill -x swaybg
uwsm-app -- swaybg -i "$image_path" -m fill 2>&1 &
echo "Wallpaper set to $image_path"