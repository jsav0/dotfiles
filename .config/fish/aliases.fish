# general navigation
alias bgs 'cd ~/.local/backgrounds'
alias bin 'cd ~/.local/bin'
alias cfg 'cd ~/.config'
alias g 'cd ~/gits/'


# gopher pastebin
alias 1337 'nc 0x1A4.1337.cx 9998'


# general simplifications
alias latr 'ls -latr'
alias vi 'nvim'

# herbstclient
alias hc 'herbstclient'

# xbps-query
#alias xi 'sudo xbps-install -Su'
#alias xq 'sudo xbps-query -R'
#alias xqs 'sudo xbps-query -Rs'

# change git config
function gconf 
	~/.local/bin/gitconf.sh $argv[1];
end


# get public ip
function wip
        #dig +short myip.opendns.com @resolver1.opendns.com
	curl -s https://canihazip.com/s
end


# get info on any public ip 
function ipi
	~/.local/bin/ipinfo.sh $argv[1];
end


