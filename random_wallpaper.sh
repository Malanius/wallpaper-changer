#!/bin/bash
# omarchy uses swaybg and has fd installed by default

# Set to your wallpapers directory
WALLPAPER_DIR=~/Pictures/wallpapers/waifus
image_path="$(fd . -e jpg -e png -e jpeg -e webp "$WALLPAPER_DIR" | shuf -n 1)"

pkill -x swaybg
uwsm-app -- swaybg -i "$image_path" -m fill 2>&1 &