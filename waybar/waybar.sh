#!/usr/bin/env sh

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; notify-send "Waybar running"; done
#sleep 1

# Launch main
waybar
