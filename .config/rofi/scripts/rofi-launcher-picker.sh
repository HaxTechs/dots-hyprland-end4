#!/usr/bin/env bash

CHOICE=$(printf "Launcher 2 (type-2)" | rofi -dmenu -i -p "Choose Launcher Type")

case "$CHOICE" in
  *2*) ~/.config/rofi/scripts/launcher_t2 ;;

  *) exit 1 ;;
esac
