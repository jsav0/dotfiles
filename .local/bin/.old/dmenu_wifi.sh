#!/bin/bash
# savage
# quick wireless menu to scan and connect 
# dmenu, wpa_supplicant, iw

# Notes:
## -- very little error handling exists
## -- it works for most of my case. sometimes it neads tweaking. 
## -- i like it

######## DEBUG ########
## necessary if exected via keybinding ##
#set -x # debugging
#exec > $HOME/dmenu_wifi.log 2>&1

######## FUNCTIONS ########

notify() { \
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
	[ $(echo $INTFC | awk '{print $1}') == "exit" ] && exit 1  
}

# initialize a basic wpa_supplicant configuration file 
initialize_config() { \
	touch /etc/wpa_supplicant/wpa_supplicant.conf
	echo "ctrl_interface=/run/wpa_supplicant" > /etc/wpa_supplicant/wpa_supplicant.conf
	echo "ctrl_interface_group=wheel" >> /etc/wpa_supplicant/wpa_supplicant.conf
	echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
	echo "initialized empty config.."
	initialize_wpasupplicant
}

# start wpa_supplicant on selected interface with the basic configuration file (required to begin scanning) 
initialize_wpasupplicant() {
	ps cax | grep wpa_supplicant > /dev/null
	if [ $? -eq 0 ]; then
		echo "wpa_supplicant is already running. " 
	else
		echo "starting wpa_supplicant..."
		wpa_supplicant -i $INTFC -c /etc/wpa_supplicant/wpa_supplicant.conf -B
	fi
}

# scan for nearby networks
scan_for_ssid() { \
	AP_LIST=$(wpa_cli scan >/dev/null && wpa_cli scan_results | column -t | \
	tail -n +3 | sort -k3 -n -r | awk '{print}') 
	SSID=$(printf "exit\nrescan\n$AP_LIST" | dmenu -l 30 -p "Select a nearby network: ")
	RESULT=$(echo $SSID | awk '{print $1}')
	case $RESULT in
		exit )		exit 1;;
		rescan )	scan_for_ssid;;
		*) 		SSID=$(echo $SSID |  awk '{ for (i=5; i<=NF; i++) \
				printf("%s ", $i) }END{ print"" }' | sed 's/ *$//');echo "Selected SSID: $SSID";;
	esac
}

# if the wireless AP does not have an accompanying WPA / WEP key 
# but has a captive portal instead, this should work
# Note: this is a one time connection and will not save the network
connect_to_open_network() { \
	killall wpa_supplicant 2> /dev/null
	ip link set down $INTFC
	ip link set up $INTFC
	iw dev $INTFC connect -w "$SSID"
	dhcpcd -n $INTFC
	notify "connected" 
}


# prompt for private key + execute wpa_passphrase + and then execute dhcpcd to get IP address
# (will not return error if pre shared key is wrong)
configure_wpa_network() { \
#	killall wpa_supplicant 2> /dev/null
	ip link set down $INTFC
	ip link set up $INTFC
	CONTINUE=$(echo -e "yes\nexit" | dmenu -p "Continue: configure WPA with PSK? (y or exit)")
	case $CONTINUE in
		yes)    PSK=$(echo -e | dmenu -p "Enter WPA/WPA2 Key: " | awk '{print}')
			wpa_passphrase "$SSID" "$PSK" | tee -a /etc/wpa_supplicant/wpa_supplicant.conf #> /dev/null 2>&1
			wpa_cli reconfigure > /dev/null 2>&1
			dhcpcd -n $INTFC
			if [ $? -eq 0 ]; then 
				notify "connected"
			else
				exit 1
			fi
			;;
		* )	exit 1
			;;
	esac
}

# check if network configuration already exists for SSID. 
is_network_known() { \
##
	network_type() { \
		NETWORK_TYPE=$(printf "exit\\nOPEN NETWORK\\nWPA NETWORK" | dmenu -p "Select the network type: " | awk '{print $1}')
	}
##
	grep "$SSID" /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null 2>&1 && KNOWN=YES || KNOWN=NO
	if [ $KNOWN == "NO" ] ; then
		NETWORK_TYPE=$(printf "exit\\nOPEN NETWORK\\nWPA NETWORK" | dmenu -p "Select the network type: " | awk '{print $1}')
	else
		NETWORK_TYPE=$(printf "yes\\nno" | dmenu -p "Network profile already exists. Do you wish to overwite? ")
		if [ $NETWORK_TYPE == "yes" ]; then
			network_type
		fi
	fi
	case $NETWORK_TYPE in 
		OPEN) connect_to_open_network;;
		WPA) configure_wpa_network;;
		*) echo "is_network_known: error";;
	esac
}

# this function kinda wraps a collection of above functions in sequence in order to connect to a standard WPA/WPA2 network. 
new_network() { \
	select_interface
	initialize_config
	#initialize_wpasupplicant
	scan_for_ssid
	is_network_known
}


# load a saved network profile
load_network() { \
	select_interface
	initialize_wpasupplicant
	ID=$(wpa_cli list_networks | column -t | \
	tail -n +3 | dmenu -l 10 -p \
	"Chose a configuration to load: (or type X to close)" | awk '{print $1}')
	case $ID in
		x|X )	exit 1
			;;
		* )	wpa_cli select_network $ID > /dev/null 2>&1
			dhcpcd -n $INTFC  
			;;
	esac
}


load() { \
	choice=$(echo -e "y\nn\nexit" | \
	dmenu -p "Load existing wireless profile? (y or n)")
	case $choice in
		[yY]* )	load_network;;
		* )	exit 1;;
	esac
}


# start the dmenu prompt 
prompt() { \
	DO=$(echo -e "Connect to a new wireless network\nLoad existing wireless profile" \
	| dmenu -p "What do you want to do?" | awk '{print $1}')
	case $DO in
		Connect )	new_network;;
		Load	)	load;;
		* )		exit 1;;
	esac
}


## -- START CASE -- ##
case "$1" in
	new )	new_network;;
	load )	load;;
	* )	prompt;;
esac

