#!/bin/sh
# get weather
# savage

curl -s "wttr.in/clt?format=3" | awk '{print $1 " " $NF}'
