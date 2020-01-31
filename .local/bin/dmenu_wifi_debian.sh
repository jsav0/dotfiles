#!/bin/bash
# savage
# quick wireless menu to scan and connect to wireless networks 
# dmenu, iw, wpa_supplicant, dhcpcd

# Notes:
## this script uses dhcpcd and expects that the wpa_supplicant hook is installed
## ie: cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/
## -- very little error handling exists
## -- it works for most of my case. sometimes it neads tweaking. 
## -- i like it

######## DEBUG (necessary if executed via keybinding ) ########
#set -x # debugging
#exec > $HOME/dmenu_wifi.log 2>&1

SYSTEM=$(lsb_release -a 2> /dev/null | awk '/ID/{print $3}')

######## FUNCTIONS ########

notify() { \ # necessary when im in my void musl systems
	### oh for f*cks sake  
	export USER="savage"
	export USER_ID="1000"
	sudo -u $USER DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus notify-send $1
	export USER=""
	export USER_ID=""
}

# prompt to select a wireless interface
select_interface() { \
	INTFC_LIST=$(iw dev | awk '/Interface/{print $2}')
	INTFC="$(printf "exit\\n$INTFC_LIST" | dmenu -l 5 -p "Chose a wireless interface: " )"
	[ $(echo $INTFC | awk '{print $1}') == "exit" ] && exit 3  
}

# initialize a basic wpa_supplicant configuration file 
initialize_config() { \
	echo ""
	echo "ctrl_interface=/run/wpa_supplicant" > /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf
	echo "ctrl_interface_group=sudo" >> /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf
#	echo "ctrl_interface_group=wheel" >> /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf
	echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf
}

# start wpa_supplicant on selected interface with the basic configuration file (required to use wpa_cli and begin scanning) 
initialize_wpasupplicant() {
	[ ! -S /run/wpa_supplicant/$INTFC ] && wpa_supplicant -i $INTFC -c /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf -B
}

# scan for nearby networks
scan_for_ssid() { \
	initialize_wpasupplicant
	scan() { \
		wpa_cli scan && echo "scanning for APs...";sleep 5
		AP_LIST=$(wpa_cli scan_results | column -t | tail -n +3 | sort -k3 -n -r | awk '{print}') 
		SSID=$(printf "exit\nrescan\n$AP_LIST" | dmenu -l 30 -p "Select a nearby network: ")
		case $(echo $SSID | awk '{print $1}') in
			exit )		exit 3;;
			rescan )	scan;;
			* ) 		SSID=$(echo $SSID |  awk '{ for (i=5; i<=NF; i++) \
					printf("%s ", $i) }END{ print"" }' | sed 's/ *$//');echo "Selected SSID: $SSID";
					NETWORK_ID=$(wpa_cli list_networks | awk "/$SSID\t/"'{print $1}') # check if network configuration already exists for SSID. 
					echo $NETWORK_ID
					echo $SSID
					if [ ! -z $NETWORK_ID ]; then
						if [ $(printf "yes\\noverwrite" | dmenu -p "Network profile already exists. Do you wish to connect? ") == "yes" ]; then
							wpa_cli select_network $NETWORK_ID
							exit 5
						else
							echo "overwrite code here.."
							exit 5
						fi
					else
						echo "network does not exist yet"
					fi

					;;
					
		esac
	}
	scan
}


# if the wireless AP does not have an accompanying WPA / WEP key 
# but has a captive portal instead, this should work
connect_to_open_network() { \
	[ ! $(grep "ssid=\"$SSID\"" /etc/wpa_supplicant/wpa_supplicant-wlan0.conf) ] && \
	echo -e "network={\n\tssid="\"$SSID"\"\n\tkey_mgmt=NONE\n}" >> /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf
	
	dhcpcd $INTFC -n && notify-send "connecting.."
}


# prompt for private key + execute wpa_passphrase + execute dhcpcd to reconfigure wpa supplicant and get IP address
# (will not return error if pre shared key is wrong)
configure_wpa_network() { \
	PSK=$(echo -e | dmenu -p "Enter PSK: " | awk '{print}')
	wpa_passphrase "$SSID" "$PSK" | tee -a /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf > /dev/null 2>&1
	wpa_cli -i $INTFC reconfigure > /dev/null 2>&1
	STATUS=$(wpa_cli -i $INTFC status | awk -F'=' '/wpa_state/{print $2}')
	while [ "$STATUS" != "COMPLETED" ]
	do
		sleep 3
		STATUS=$(wpa_cli -i $INTFC status | awk -F'=' '/wpa_state/{print $2}')
	done
	dhcpcd $INTFC -n && notify-send "connecting.." 
}

configure_network() { \
	NETWORK_TYPE=$(printf "OPEN\\nWPA/WPA2\\nexit" | dmenu -p "Select the network security type: " | awk '{print $1}')
	case $NETWORK_TYPE in
		OPEN) connect_to_open_network;;
		WPA/WPA2) configure_wpa_network;;
	esac
}

# this function kinda wraps a collection of above functions in sequence in order to connect to a standard WPA/WPA2 network. 
new_network() { \
	select_interface
	[ ! -f /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf ] && initialize_config || initialize_wpasupplicant
	scan_for_ssid
	configure_network
}


# load a saved network profile
load_network() { \
	select_interface
	[ ! -f /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf ] && echo "sorry. there are no saved networks on this interface"
	initialize_wpasupplicant
	NETWORK_ID=$(wpa_cli list_networks | column -t | tail -n +3 | dmenu -l 10 -p \
	"Chose a configuration to load: (or type X to close)" | awk '{print $1}')
	case $ID in
		x|X )	exit 3;;
		* )	[ ! -f /var/run/dhcpcd-$INTFC.pid ] && dhcpcd -n $INTFC 
			wpa_cli select_network $NETWORK_ID > /dev/null 2>&1;;
	esac
}


load() { \
	choice=$(echo -e "y\nn\nexit" | \
	dmenu -p "Load existing wireless profile? (y or n)")
	case $choice in
		[yY]* )	load_network;;
		* )	exit 2;;
	esac
}


# start the dmenu prompt 
prompt() { \
	DO=$(echo -e "Connect to a new wireless network\nLoad existing wireless profile" \
	| dmenu -p "What do you want to do?" | awk '{print $1}')
	case $DO in
		Connect )	new_network;;
		Load	)	load;;
		* )		exit 2;;
	esac
}


## -- START CASE -- ##
case "$1" in
	new )	new_network;;
	load )	load;;
	* )	prompt;;
esac

