#!/bin/sh
# get weather
curl -s "wttr.in/CLT?format=3" | awk '{print $1 " " $NF}' | sed 's/°//'
