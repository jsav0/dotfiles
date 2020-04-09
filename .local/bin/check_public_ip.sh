#!/bin/bash

JSON=/tmp/ip_json

#ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
IP=$(curl -s https://canihazip.com/s)
IP_INFO=$(curl -s https://ipinfo.io/$IP/json --output $JSON)
CITY=$(cat $JSON | jq .city | tr -d '\"')
REGION=$(cat $JSON | jq .region | tr -d '\"')
COUNTRY=$(cat $JSON | jq .country | tr -d '\"')

printf "$IP $CITY, $REGION, $COUNTRY" > /tmp/public_ip
