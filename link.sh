#!/bin/sh

case $1 in
	fish) rm -rf ~/.config/fish&&ln -s ~/gits/dotfiles/.config/fish ~/.config/;;

	bin) rm -rf ~/.local/bin&&ln -s ~/gits/dotfiles/.local/bin ~/.local/;;
	bg) rm -rf ~/.local/backgrounds&&ln -s ~/gits/dotfiles/.local/backgrounds ~/.local/;;
	*) echo "error. Try again or setup a new case";;
esac

