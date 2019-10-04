#!/bin/bash
#

function help() {
  echo "try again with one of these:"
  echo "bg  ,  bin  ,  fish  ,  hlwm  ,  i3"
}

case $1 in
	bg) rsync -rz --progress .local/backgrounds ~/.local/;;
	bin) rsync -rz --progress .local/bin ~/.local/;;
	fish) rsync -rz --progress .config/fish ~/.config/;;
	hlwm) rsync -rz --progress .config/herstluftwm ~/.config/herbstluftwm;;
	i3) rsync -rz --progress .config/i3 ~/.config/i3;;
  *) help
esac

