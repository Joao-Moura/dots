#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare -r player_status=$(playerctl --player=spotify status 2> /dev/null)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
    printf "$player_status: $(playerctl metadata title) - $(playerctl metadata artist)"
else
    printf "Not running"
fi
