#!/bin/bash

# generate a list of manually installed void packages
get_installed_pkgs() {
	[ -f pkg.list ] && rm pkg.lst
	while IFS= read pkg; do
		printf "$pkg " >> pkg.lst
	done < <(xbps-query -m | sed 's/\-[0-9].*$//')
}

# install a list of void packages from pkg.lst
install_pkgs(){
	sudo xbps-install -Suy $(sed '/^$/d;/^#/d' < pkg.lst) 
} 

case "$1" in
	install)	install_pkgs
			;;
	copy)		get_installed_pkgs
			;;
	*)		exit 1
			;;
esac
