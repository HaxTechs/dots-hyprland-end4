#!/usr/bin/env bash

# Rofi theme file
ROFI_DIR="$HOME/.config/rofi/launchers/styles"
THEME='simple'

CHOICE=$(printf "Launcher 2 (type-2)" | rofi -dmenu -i -p "Choose Launcher Type" -theme ${ROFI_DIR}/${THEME}.rasi)

case "$CHOICE" in
  *2*) ~/.config/rofi/scripts/launcher_t2 ;;

  *) exit 1 ;;
esac
