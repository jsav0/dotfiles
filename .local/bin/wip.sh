#!/bin/sh
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
notify-send "$ip"
