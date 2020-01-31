#!/bin/sh

LIST_OF_IPS=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}(\/([0-9]|[1-2][0-9]|3[0-2]))?' < /dev/stdin)
echo $LIST_OF_IPS | tr " " "\n" | dmenu | awk '{print $1}'


