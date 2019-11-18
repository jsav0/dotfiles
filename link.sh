#!/bin/bash

function help() {
	echo "try using one of the following or creating a new case:"
	echo "i3 , polybar , misc , sounds , fish  ,  dunst  ,  bg  ,  bin"
}

case $1 in
	i3) rm -rf ~/.config/i3&&ln -s ~/gits/dotfiles/.config/i3 ~/.config/;;
	polybar) rm -rf ~/.config/polybar&&ln -s ~/gits/dotfiles/.config/polybar ~/.config/;;
	fish) rm -rf ~/.config/fish&&ln -s ~/gits/dotfiles/.config/fish ~/.config/;;
	misc) rm -rf ~/.config/misc&&ln -s ~/gits/dotfiles/.config/misc ~/.config/;;
	dunst) rm -rf ~/.config/dunst&&ln -s ~/gits/dotfiles/.config/dunst ~/.config/;;

	bin) rm -rf ~/.local/bin&&ln -s ~/gits/dotfiles/.local/bin ~/.local/;;
	bg) rm -rf ~/.local/backgrounds&&ln -s ~/gits/dotfiles/.local/backgrounds ~/.local/;;
	sounds) rm -rf ~/.local/sounds&&ln -s ~/gits/dotfiles/.local/sounds ~/.local/;;
	*) help #echo "error. Try again or setup a new case";;
esac

