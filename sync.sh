#!/bin/bash
#

function help() {
  echo "try again with one of these:"
  echo "bin  ,  fish  ,  hlwm  ,  i3 , dunst , nvim"
}

case $1 in
	bin) rsync -rz --progress .local/bin ~/.local/;;
	fish) rsync -rz --progress .config/fish ~/.config/;;
	hlwm) rsync -rz --progress .config/herstluftwm ~/.config/herbstluftwm;;
	i3) rsync -rz --progress .config/i3 ~/.config/i3;;
	nvim) rsync -rz --progress .config/nvim ~/.config/nvim;;
	dunst) rsync -rz --progress .config/dunst ~/.config/dunst;;
  *) help
esac

