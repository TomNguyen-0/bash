#!/bin/bash

source /root/Desktop/programs/help_menu.sh

path_from=$2
path_to=$3
scp_success=0	# 0 is false

#				### hidden menu ####
#if we want to grab more than one files but only with text containing
#example: pull -t `dirclass`episode_4* ./
#what is it doing?: scp -p root@192.168.0.4:'/root/Desktop/notes/udemy/udemy_hacking/episode_4*' ./
if [ $# -eq  3 ] && [ $1 == "-t" ]	#library file containing text
then
	#echo scp -p root@192.168.0.4:\'$path_from\' $path_to			#used for debugging \' did not work for the command below instead needed to use ''
	scp -p root@192.168.0.4:''$path_from'' $path_to
	scp_success=1
fi

#push and pull commands
if [ $# -eq  3 ] && [ $1 == "-p" ]	#library is the target
then
	scp -p "$path_from" root@192.168.0.4:"$path_to"
	scp_success=1
elif [ $# -eq 2 ]	#library is the source
then	#there are only two arguments here
	path_from=$1
	path_to=$2
	#this was used to debugged
	#echo "what is path_from: root@192.168.0.4:$path_from"	
	#echo "what is path_to: $path_to"
	scp -p root@192.168.0.4:"$path_from" "$path_to"
	scp_success=1
fi

#help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu '$0 pull path_from path_to\npull ~/.bash_alias ~/\nto push use: push [this_machine_path] [to_library] \nif library is the target push with -p: pull -p path_from path_to\nCannot use wildcard *'
	exit 0
elif [ $scp_success -eq 1 ]
then
	exit 0
else
	echo "try: $0 -h"
	exit 0
fi


