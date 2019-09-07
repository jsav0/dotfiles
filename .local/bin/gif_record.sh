#!/usr/bin/bash
# savage
#
# depends: dmenu, byzanz-record, notify-send
# demnu for prompting a custom duration
# byzanz-record is the screen recorder utility
# notify-send for sending screen notifications
#
TIME=$(date '+%Y-%m-%d_%H%M-%S')
DIR=$HOME/screencaptures
beep() {
    paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga &
}
prompt() {
	choice=$(printf "window" |dmenu -p "Select recording style: ")
	case $choice in
		window) record_window_gif;;
	  *) exit 1;;
	esac
}

record_window_gif() {
	D=$(printf "10\n15\n20\n30\n60" | dmenu -p "Please select or enter the duration: ")
	# Window geometry
	XWININFO=$(xwininfo)
	read X < <(awk -F: '/Absolute upper-left X/{print $2}' <<< "$XWININFO")
	read Y < <(awk -F: '/Absolute upper-left Y/{print $2}' <<< "$XWININFO")
	read W < <(awk -F: '/Width/{print $2}' <<< "$XWININFO")
	read H < <(awk -F: '/Height/{print $2}' <<< "$XWININFO")
	sleep 1
	beep
	byzanz-record -c --delay=0 --duration=$D --x=$X --y=$Y --width=$W --height=$H "$DIR/GIFrecord_$TIME.gif"
	beep
	# notify end of recording
	notify-send "Screencast saved to $DIR/GIFrecord_$TIME.gif"
}

prompt
