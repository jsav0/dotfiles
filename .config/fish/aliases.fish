# general navigation
alias bin 'cd ~/.local/bin'
alias config 'cd ~/.config'
alias g 'cd ~/gits/'

# gopher pastebin
alias 1337 'nc 0x1A4.1337.cx 9998'

# general simplifications
alias l 'ls'
alias latr 'ls -latr'
alias vi 'nvim'
alias clip 'xclip -selection clipboard'

# herbstclient
alias hc 'herbstclient'

# change git config
function gconf 
	~/.local/bin/gitconf.sh $argv[1];
end
alias gcm='git commit -m'

# get public ip
function wip
        #dig +short myip.opendns.com @resolver1.opendns.com
	curl -s https://canihazip.com/s
end

# get info on any public ip 
function ipi
	~/.local/bin/ipinfo.sh $argv[1];
end

# get weather info
function wx
	curl wttr.in/Charlotte;
end

# chmod x
function x
	chmod +x $argv[1];
end

