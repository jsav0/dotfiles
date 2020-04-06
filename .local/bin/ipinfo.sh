#!/usr/bin/bash
# savage
# uses ipinfo.io , returns JSON response 
# it is then possible to pipe results to jq for parsing
# i.e. `curl https://ipinfo.io/$1/json | jq .city,.postal,.org`
# the flow to pull IPs from the terminal: st external pipe -> ip_regex.sh -> ipinfo.sh 


link=$(cat /dev/stdin)
ip=$(curl -s https://ipinfo.io/$link/json)
ip_info=$(curl -s https://ipinfo.io/$link/json | jq .ip,.city,.region,.country)

#notify-send "$ip_info"
echo "$ip_info"


