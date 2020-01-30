#!/usr/bin/env sh

# Feed script a url or file location.
# If an image, it will view in sxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens 1 in browser.

EDITOR=/bin/nvim
BROWSER=/bin/firefox

link=$(cat /dev/stdin)

# If no url given. Opens browser. For using script as $BROWSER.
[ -z "$link" ] && exit 0

case "$link" in
	*mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtu.be*|*hooktube.com*|*bitchute.com*)
		setsid mpv --input-ipc-server=/tmp/mpvsoc$(date +%s) -quiet "$link" >/dev/null 2>&1 & ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$link" > "/tmp/$(echo "$link" | sed "s/.*\///")" && sxiv -a "/tmp/$(echo "$link" | sed "s/.*\///")"  >/dev/null 2>&1 & ;;
	*mp3|*flac|*opus|*mp3?source*)
		setsid tsp curl -LO "$link" >/dev/null 2>&1 & ;;
	*)
		exit 0;
esac
