#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#Will send a message to the screen after x amount of time.

#predefined variables:
temperture_value_temp1=130
temperture_value_core0=95
keep_going=true
sleep_variable=60s

#if user ask for help
if [ $# -eq 1 ]
then
	if [ $1 == "-h" ]
	then
		help_menu 'alarm 1[smh] message \nexample: alarm 1m "this is the message you want to display"' #[smh] stands for second, minutes, hours
		help_menu 'alarm temp\&' #will run in the background; use 'jobs' to see it running in the background
		exit 0
	fi
	if [ $1 == "temp" ]
	then
                while($keep_going)
                do
			sleep $sleep_variable
			temperture_core0=$(sensors -f | grep Core | grep -oh "+[0-9][0-9].[0-9]" | grep -oh [0-9][0-9].[0-9])
			temperture_temp1=$(sensors -f | grep temp1 | grep -oh "+[0-9][0-9][0-9].[0-9]" | grep -oh [0-9][0-9][0-9].[0-9] | head -n 1)
			if [[ (($temperture_core0 > $temperture_value_core0)) ]] #for comparing decimals
			then
				echo core is over $temperture_value_core0\;  current: $temperture_core0
				#keep_going=false
			fi
			if [[ (($temperture_temp1 > $temperture_value_temp1)) ]]
			then
				echo virtual adapter temperture is over $temperture_value_temp1\; current: $temperture_temp1
				#keep_going=false
			fi
                done
                exit 0
	fi
fi

echo $#

if [ $# -eq 2 ]
then
	#doesn't work fix this up some other time
	if [ $2 == "smh" ]
	then
		sleep $1 && echo $2 &
	else
		exit 0
	fi
else
	exit 0
fi
