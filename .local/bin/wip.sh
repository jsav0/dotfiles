#!/bin/bash
#ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
ip=$(curl -s https://canihazip.com/s)
#notify-send "$ip"
ip_info=$(curl -s https://ipinfo.io/$ip/json | jq .ip,.city,.region,.country)
echo ""
echo "Public IPv4 Address: $ip"
echo ""
echo "$ip_info"

