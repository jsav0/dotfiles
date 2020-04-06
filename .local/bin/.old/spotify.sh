#!/usr/bin/bash
# savage
# spotify flatpak launcher

spotify(){
if ! `flatpak ps | grep -q Spotify`; then
        notify-send "Starting Spotify now ... please wait ..."
        flatpak run com.spotify.Client >/dev/null 2>&1 &
else
        notify-send "Spotify is already running!"
fi
}

spotify
