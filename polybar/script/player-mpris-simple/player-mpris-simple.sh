#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$playerctl metadata title" = "Advertisement" ]; then
    playerctl next
elif [ "$player_status" = "Playing" ]; then
    echo "Playing: $(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo "Paused: $(playerctl metadata artist) - $(playerctl metadata title)"
else
		echo "No music playing!"
fi
