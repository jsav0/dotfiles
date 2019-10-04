#!/bin/sh

function help() {
	echo "try using one of the following or creating a new case:"
	echo "fish  ,  dunst  ,  bg  ,  bin"
}

case $1 in
	fish) rm -rf ~/.config/fish&&ln -s ~/gits/dotfiles/.config/fish ~/.config/;;
	dunst) rm -rf ~/.config/dunst&&ln -s ~/gits/dotfiles/.config/dunst ~/.config/;;

	bin) rm -rf ~/.local/bin&&ln -s ~/gits/dotfiles/.local/bin ~/.local/;;
	bg) rm -rf ~/.local/backgrounds&&ln -s ~/gits/dotfiles/.local/backgrounds ~/.local/;;
	*) help #echo "error. Try again or setup a new case";;
esac

