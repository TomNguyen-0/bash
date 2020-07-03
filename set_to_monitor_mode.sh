#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#this is to set my wireless adatper to monitor mode

#help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu './set_to_monitor_mode.sh wlan0'
	exit 0
fi

if [ $# -eq 0 ]
then
	help_menu './set_to_monitor_mode.sh wlan0'
	exit 0
fi

airmon-ng check kill
ifconfig $1 down
macchanger -r $1
iwconfig $1 mode monitor
ifconfig $1 up
iwconfig		#will display the configuration so that we can check if wlan1 is in monitor mode

#To do the same thing as this program without writing one up use: $airmon-ng start wlan0
#this will do the same thing
#To bring the wifi back up do these steps:
	#$airmon-ng stop wlan0mon
	#$service network-manager start 	(same: /etc/init.d/network-manager start)
