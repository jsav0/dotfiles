#!/usr/bin/bash
# Give dmenu list of all unicode characters to copy.

# Must have xclip installed to even show menu.
xclip -h 2>/dev/null || exit

if [ -e ~/.config/misc/unicode ]; then
	chosen=$(grep -v "#" ~/.config/misc/unicode | dmenu -i -l 20 -fn Monospace-12)
else
	exit 1
fi

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
notify-send "'$c' copied to clipboard." &

s=$(echo "$chosen" | sed "s/.*; //" | awk '{print $1}')
echo "$s" | tr -d '\n' | xclip
notify-send "'$s' copied to primary." &
