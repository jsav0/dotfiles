#!/bin/bash

UI_CHOICES="piirc\npihole\ntherouter\nubmon\noiduabox"
UI=$(printf "$UI_CHOICES" | dmenu -p "Select a webUI:" | awk '{print $1}') 
case $UI in 
	pihole) firefox pi.hole/admin;;
	therouter) firefox 192.168.10.1;;
	ubmon) firefox ubmon/login;;
	oiduabox) firefox oiduabox/playback;;
	piirc) firefox piirc:7272;;
	*) exit 0;;
esac


