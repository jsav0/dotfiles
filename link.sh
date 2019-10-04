#!/bin/sh

case $1 in
	fish) rm -rf ~/.config/fish&&ln -s ~/gits/dotfiles/.config/fish ~/.config/;;
	*) echo "error. Try again or setup a new case";;
esac

