#!/bin/bash
# n0
#
# File: dmenu_wifi.sh
# Description: wifi manager (iwd) with dmenu
#
# make sure iwd is enabled
# ln -s /etc/sv/dbus /var/service/
# ln -s /etc/sv/iwd /var/service/
#
# and typically dhcpcd 
# ln -s /etc/sv/dhcpcd /var/service/dhcpcd
#
# a110w 

iwctlstrip() {
  tail -n +3 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

get_interface() {
    INTFC=$(iwctl device list | iwctlstrip | dmenu -c -l 10 -p "Select an interface:" | awk '{print $1}') 
}

scan() {
    iwctl station $INTFC scan && sleep 1
    SCAN_RESULTS=$(iwctl station $INTFC get-networks | iwctlstrip)
}

get_ssid() {
    CHOSEN=$(printf "$SCAN_RESULTS" | dmenu -c -l 10)
    SSID=$(printf "$CHOSEN" | awk -F" {2,}" '{print $2}' | sed 's/>//' | awk '{$1=$1;print}')
    [[ "$(printf "$CHOSEN" | awk -F" {2,}" '{print $3}')" == "psk" ]] && PSK=1 || PSK=0
    [[ "$(printf "$CHOSEN" | awk -F" {2,}" '{print $3}')" == "open" ]] && OPEN=1 || OPEN=0
    [[ "$CHOSEN" == "rescan" ]] && {
        scan
        get_ssid
    }; [[ "$CHOSEN" == "exit" ]] && exit 1 
}

get_psk() {
    PSK=$(printf 'exit\n' | dmenu -c -p "Enter WPA/WPA2 Secret Passphrase:" | awk '{print}')
}

connect_with_open() {
    iwctl station $INTFC connect "$SSID" 
}

connect_with_psk() {
    get_psk || exit 1
    iwctl station $INTFC connect "$SSID" -P "$PSK"
}

connect_to_a_network() {
    get_interface && scan && get_ssid
    [[ "$PSK" == "1" ]] && connect_with_psk && notify-send "connected to $SSID"
    [[ "$OPEN" == "1" ]] && connect_with_open && notify-send "connected to $SSID"

}

connect_to_a_network

