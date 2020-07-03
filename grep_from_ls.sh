#!/bin/bash

if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	echo "To use the program use the commands:"
	echo "	./grep_from_ls.sh statement_you_are_searching_for"
	echo "OR"
	echo "	vim \`gfl install_my\`"
	exit 0
else
	echo $(ls -ltr ./ | grep $1 | awk '{print $9}') > ./tmp.txt #using print will put a spaced after each print $9
	sed 's/ /\n/g' tmp.txt #tr -s " " "\n" < tmp.txt #couldn't get '|tr " " "\n" to work
	rm ./tmp.txt #this will create a new line and then remove the tmp.txt file
fi
