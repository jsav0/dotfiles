#!/bin/bash

UI_CHOICES="piirc\npihole\ntherouter\neyez"
UI=$(printf "$UI_CHOICES" | dmenu -p "Select a webUI:" | awk '{print $1}') 
case $UI in 
	pihole) firefox pi.hole/admin;;
	therouter) firefox 192.168.10.1;;
	piirc) firefox piirc:7272;;
	eyez) firefox --new-instance -P blank --class=eyez eyez;;
	*) exit 0;;
esac


