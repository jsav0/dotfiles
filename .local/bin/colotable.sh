#!/bin/bash

colotable(){
o=0
for ((i=0;i<256;i++))
do
[ $o -gt 5 ] && printf "\n" && o=0
o=$(($o+1))
tput setaf $i
printf "  %03d  " "$i"
tput setab $i
printf "       " 
tput sgr0
done
}

colotable
