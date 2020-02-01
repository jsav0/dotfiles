#!/bin/bash

function help() {
	echo "try using one of the following or creating a new case:"
	echo "i3 , hlwm , polybar , misc , fish  ,  dunst  ,  bg  ,  bin"
}

case $1 in
	i3) rm -rf ~/.config/i3&&ln -s ~/gits/dotfiles/.config/i3 ~/.config/;;
	hlwm) rm -rf ~/.config/herbstluftwm&&ln -s ~/gits/dotfiles/.config/herbstluftwm ~/.config/;;
	polybar) rm -rf ~/.config/polybar&&ln -s ~/gits/dotfiles/.config/polybar ~/.config/;;
	fish) rm -rf ~/.config/fish&&ln -s ~/gits/dotfiles/.config/fish ~/.config/;;
	misc) rm -rf ~/.config/misc&&ln -s ~/gits/dotfiles/.config/misc ~/.config/;;
	dunst) rm -rf ~/.config/dunst&&ln -s ~/gits/dotfiles/.config/dunst ~/.config/;;

	bin) rm -rf ~/.local/bin&&ln -s ~/gits/dotfiles/.local/bin ~/.local/;;
	bg) rm -rf ~/.local/backgrounds&&ln -s ~/gits/dotfiles/.local/backgrounds ~/.local/;;
	*) help #echo "error. Try again or setup a new case";;
esac

