#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#this is to pass in the mac address and the adapter mac address

#help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu './dumpgo.sh [bssid] [channel] [filename] \n./dumpgo.sh 11:22:33:44:55:66 3 wpa_handshake\nalso use: dump \n will always use wlan0'
	exit 0
fi

if [ $# -eq 3 ]
then
	airodump-ng --bssid $1 --channel $2 --write $3 wlan0
elif [ $# -eq 0 ]
then
	airodump-ng wlan0
fi

#reaver --bssid $1 --channel $2 --interface wlan0 -vvv --no-associate -r 2:360

