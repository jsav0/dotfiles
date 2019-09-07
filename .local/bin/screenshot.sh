#!/bin/sh
# savage
# screenshot utility
# using: maim, dmenu
# select a region and copy to clipboard or save to .png

prompt() { \
	CHOICE=$(printf "save\ncopy\nexit" | dmenu -p "Select screenshot type: ")
	case $CHOICE in
		save) maim -s > /tmp/ss.png;;
		copy) maim -s | xclip -selection clipboard -t image/png;;
		exit) exit 0;;
		*) exit 1;;
	esac
}

case "$1" in
	*) prompt;;
esac
