#!/bin/bash

######couldn't get this work because history is a interactive only instead I found a fast way of pushing the last command to the file
######solution: echo !! > file.txt

#This is to add the last command to a file
#To use this: program /path/to/file.txt

source help_menu.sh

#print out a message to help user 
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu 'program_name /path/file_name.txt \nexample: ./add_last_command_to_file.sh file.txt'
	exit 0
else #contains a file name instead
	echo $(eval "echo !!")
	please=`history` | `tail -n 2`
	hi=$(fc -ln -1)
	echo $hi
	echo $please
fi

