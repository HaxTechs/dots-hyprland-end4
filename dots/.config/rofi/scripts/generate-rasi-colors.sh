#!/bin/bash

# Source SCSS colors from QuickShell
SCSS_FILE="$HOME/.local/state/quickshell/user/generated/material_colors.scss"
OUT_FILE="$HOME/.config/rofi/colors/material.rasi"

# Define mappings: SCSS variable => Rofi variable name
declare -A COLORS=(
  [background]="background"
  [surfaceContainer]="background-alt"
  [onSurface]="foreground"
  [primaryContainer]="selected"
  [primary]="active"
  [onError]="urgent"
)

# Start file
echo "* {" > "$OUT_FILE"

# Extract each color from SCSS
for scss_var in "${!COLORS[@]}"; do
  hex=$(grep "\$$scss_var:" "$SCSS_FILE" | awk '{print $2}' | tr -d ';')
  [[ -n $hex ]] && echo "    ${COLORS[$scss_var]}: $hex;" >> "$OUT_FILE"
done

# End file
echo "}" >> "$OUT_FILE"
