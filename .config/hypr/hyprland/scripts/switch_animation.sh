#!/bin/bash

# You can modify this file as needed.

# Directory containing animation config files 
ANIMATION_DIR="$HOME/.config/hypr/animations"
# Target file for the active animation
ACTIVE_ANIMATION="$HOME/.config/hypr/active_anim.conf"

# Check if animation directory exists
if [[ ! -d "$ANIMATION_DIR" ]]; then
    notify-send "Error" "Animation directory not found at $ANIMATION_DIR!"
    exit 1
fi

# Get list of animation files
ANIMATIONS=$(ls "$ANIMATION_DIR"/*.conf 2>/dev/null)

# Check if any animation files exist
if [[ -z "$ANIMATIONS" ]]; then
    notify-send "Error" "No animation config files found in $ANIMATION_DIR!"
    exit 1
fi

# Create a menu string for rofi (filename without path and extension)
MENU=$(basename -a --suffix=.conf "$ANIMATION_DIR"/*.conf)

# Show rofi menu and get selected animation
SELECTED=$(echo "$MENU" | rofi -dmenu -i -p "Select Animation")

# Exit if no selection made
if [[ -z "$SELECTED" ]]; then
    notify-send "Animation Switcher" "No animation selected"
    exit 0
fi

# Check if selected file exists
CONFIG_FILE="$ANIMATION_DIR/$SELECTED.conf"
if [[ ! -f "$CONFIG_FILE" ]]; then
    notify-send "Error" "Selected animation file not found!"
    exit 1
fi

# Copy the selected animation to the active animation file
cp "$CONFIG_FILE" "$ACTIVE_ANIMATION"

# Notify user of successful change
notify-send "Animation Changed" "Switched to $SELECTED animation"
