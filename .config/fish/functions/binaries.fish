function binaries
	dpkg -L $argv | grep -Po '.*/bin/\K.*'
end
