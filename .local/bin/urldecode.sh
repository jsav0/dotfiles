#!/bin/bash
VAR=$(cat /dev/stdin)
#VAR=$1

# bash solution
#printf $(echo -n "$VAR" | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')

# php solution
php -r "echo urldecode('$VAR');"
