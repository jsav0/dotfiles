#!/bin/sh
# savage
# screenshot utility
# using: maim, dmenu, curl
# features: save, copy, upload to 0x0.st 

prompt() { \
	FILE=ss_$(date +%F_%H_%M)
	CHOICE=$(printf "save\ncopy\nupload\nexit" | dmenu -p "Select screenshot type: ")
	case $CHOICE in
		save) maim -s > /tmp/$FILE.png && notify-send "screenshot saved to /tmp/ss_$(date +%F_%H_%M).png";;
		copy) maim -s | xclip -selection clipboard -t image/png;;
		upload) maim -s > /tmp/$FILE && curl -sF"file=@/tmp/$FILE" https://0x0.st | xclip -selection clipboard;;
		*) exit 0;;
	esac
}

case "$1" in
	*) prompt;;
esac
