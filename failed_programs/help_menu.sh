#!/bin/bash

#This is for creating the help menu and reduces space

help_menu(){
	if [ $# -eq 1 ]
	then
		echo -e $1	#enables interpretations of backslash escapes
	else
		exit 1 #no messages was given
	fi
}
