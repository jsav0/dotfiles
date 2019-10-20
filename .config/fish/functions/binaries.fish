function binaries
	for f in (dpkg -L "$argv" | grep "/bin/")
		basename $f
	end
end
