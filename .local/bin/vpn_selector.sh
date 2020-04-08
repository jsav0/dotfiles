#!/bin/bash
#
# n0
# File: vpn_selector.sh
# Description: quick vpn (wireguard) with dmenu or peco
# a110w
#

# debugging
#set -x 
#exec > $HOME/.vpn_selector.log 2>&1

usage() {
echo "
USAGE: ./vpn_selector.sh [OPTIONS]
  Quick vpn menu using wireguard and your choice of dmenu or peco

OPTIONS:
  -d	dmenu, depends on X environment
  -p	peco, works in a tty
"
exit 1
}

[ $# -eq 0 ] && usage

case $1 in
	-d) SELECTOR="dmenu -c -l 10 -p"
	    ;;
	-p) SELECTOR="peco --initial-index 2 --prompt"
	    ;; 
	*)  usage
	    ;;
esac

LOCATIONS=(
  'Stockholm, Sweden'
  'Gothenburg, Sweden'
  'London, United Kingdom'
  'Miami, United States'
  'Malaga, Spain'
  'Toronto, Canada'
  'Oslo, Norway'
  'Amsterdam, Netherlands'
  'Phuket, Thailand'
  'Cophenhagen, Denmark'
)

disconnect() {
VPN=$(sudo wg show | grep 'vpn\-' | awk '{print $2}')
[[ "$VPN" == "" ]] || sudo wg-quick down "$VPN" 
}

connect() {
VPN_LOCATION=$(printf '%s\n' "${LOCATIONS[@]}" | $SELECTOR "Select location: ")
CITY=$(echo $VPN_LOCATION | awk -F, '{print $1}') 
case $CITY in 
	Stockholm ) 	disconnect && sudo wg-quick up vpn-se1 &;; 
	Gothenburg )	disconnect && sudo wg-quick up vpn-se2 &;;
	London )	disconnect && sudo wg-quick up vpn-uk1 &;;
	Miami )		disconnect && sudo wg-quick up vpn-us1 &;; 
	Malaga ) 	disconnect && sudo wg-quick up vpn-es1 &;;
	Toronto ) 	disconnect && sudo wg-quick up vpn-ca1 &;;
	Oslo ) 		disconnect && sudo wg-quick up vpn-no1 &;;
	Amsterdam ) 	disconnect && sudo wg-quick up vpn-nl1 &;;
	Phuket ) 	disconnect && sudo wg-quick up vpn-th1 &;;
	Cophenhagen ) 	disconnect && sudo wg-quick up vpn-dk1 &;;
	* ) exit 1
esac
}

CHOICE=$(printf "connect\ndisconnect" | $SELECTOR "What do you want to do? ")
case $CHOICE in
	connect)	connect && notify-send "connected to: $VPN_LOCATION"
			;;
	disconnect)	disconnect;;
	*)		exit 1
esac
