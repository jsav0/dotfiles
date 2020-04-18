#!/bin/sh

main_tag() {
	firefox &
	newsboat &
	qtfm &
}

virt_tag() {
	virt-manager &
}

irc_tag() {
	ps aux | grep weechat | grep -v grep || {
		st -n "weechat" -e "/bin/weechat" & 
	}
}

case $1 in 
	main)	main_tag
		;;
	virt)	virt_tag
		;;	
	irc)	irc_tag
		;;
	all)	main_tag
		virt_tag
		irc_tag
		;;
	*) echo "usage"
esac

