#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#	table of content
#1. help menu

#1. help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu '$0 wlan0'
	exit 0
else
	echo "try: $0 -h"
fi

