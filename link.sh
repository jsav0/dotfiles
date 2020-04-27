#!/bin/bash

function help() {
	echo "try using one of the following or creating a new case:"
	echo "zathura , nvim , sxhkd , i3 , hlwm , misc , fish  ,  dunst ,  bin , newsboat"
}

case $1 in
	sxhkd) rm -rf ~/.config/sxhkd&&ln -s ~/gits/dotfiles/.config/sxhkd ~/.config/;;
	nvim) rm -rf ~/.config/nvim&&ln -s ~/gits/dotfiles/.config/nvim ~/.config/;;
	zathura) rm -rf ~/.config/zathura&&ln -s ~/gits/dotfiles/.config/zathura ~/.config/;;
	i3) rm -rf ~/.config/i3&&ln -s ~/gits/dotfiles/.config/i3 ~/.config/;;
	hlwm) rm -rf ~/.config/herbstluftwm&&ln -s ~/gits/dotfiles/.config/herbstluftwm ~/.config/;;
	fish) rm -rf ~/.config/fish&&ln -s ~/gits/dotfiles/.config/fish ~/.config/;;
	misc) rm -rf ~/.config/misc&&ln -s ~/gits/dotfiles/.config/misc ~/.config/;;
	dunst) rm -rf ~/.config/dunst&&ln -s ~/gits/dotfiles/.config/dunst ~/.config/;;
	newsboat) rm -rf ~/.config/newsboat&&ln -s ~/gits/dotfiles/.config/newsboat ~/.config/;;

	bin) rm -rf ~/.local/bin&&ln -s ~/gits/dotfiles/.local/bin ~/.local/;;
	*) help #echo "error. Try again or setup a new case";;
esac

