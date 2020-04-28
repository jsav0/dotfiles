#!/usr/bin/env bash
# bash one-liner function to get temperature
# savage

celsius() {
  echo $(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))C
}

farenheit() {
  echo $((($(cat /sys/class/thermal/thermal_zone0/temp)/1000) * 9/5 + 32))F
}

celsius
