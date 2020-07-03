#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#quick change
if [ $# -eq 2 ] && [ $1 == "-eth" ]
then
	ifconfig eth0 down
	ifconfig eth0 $2 netmask 255.255.255.0 up
	systemctl start ssh
	systemctl status ssh
	exit 0
elif [ $# -eq 2 ]
then
	#online wlan0 192.168.0.30
	ifconfig $1 down
	ifconfig $1 $2 netmask 255.255.255.0 up
	exit 0
fi

#help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu './online.sh -[options]\nexample: online -lib\nor online wlan0a\nonline -eth 192.168.0.4'
	exit 0
elif [[ $1 == "-lib" ]]		#this is for the library small machine to start ssh and wifi
then
	ifconfig wlan0 down
	ifconfig wlan0 192.168.0.4 netmask 255.255.255.0 up	
	iwconfig wlan0 essid Wubalubadubdub key s:9492879952
	systemctl start ssh
	systemctl status ssh
	exit 0
else
	if [ $# -eq 1 ]
	then
		#if it reaches here then we are not start ssh but instead coming out of monitor mode
		ifconfig $1 down
		iwconfig $1 mode managed
		ifconfig $1 up
		service network-manager restart
		service network-manager status
		iwconfig $1 essid Wubalubadubdub key s:9492879952
		exit 0
	fi
	echo "forgot an arugment, try: online -h"
fi

