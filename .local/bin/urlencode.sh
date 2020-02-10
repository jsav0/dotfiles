#!/bin/bash
VAR=$(cat /dev/stdin)
#VAR=$1
php -r "echo urlencode('$VAR');"
