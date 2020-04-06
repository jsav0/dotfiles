#!/bin/sh
ip link set dev enp0s25 up
ip addr add 192.168.1.2/24 brd + dev enp0s25
ip route add default via 192.168.1.1

