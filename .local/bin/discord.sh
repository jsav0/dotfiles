#!/usr/bin/bash
# savage
# discord flatpak launcher

discord(){
if ! `flatpak ps | grep -q Discord`; then
        "Discord is not running!"
        notify-send "Starting Discord now ... please wait ..."
        flatpak run com.discordapp.Discord >/dev/null 2>&1 &
else
        notify-send "Discord is already running!"
fi
}

discord
