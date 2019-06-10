feh --bg-scale ~/.background/the_raven_by_mugwort.jpg &
compton -b & 
dunst > /dev/null 2>&1 &
while true
do
  IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1)
  TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"
  if acpi -a | grep off-line > /dev/null
  then
    BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
    xsetroot -name "$IP $BAT $TEMP" 
  else
    xsetroot -name "$IP $TEMP" 
  fi
sleep 20s
done &
exec dwm

