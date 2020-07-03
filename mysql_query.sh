#!/bin/bash

source /root/Desktop/programs/help_menu.sh

#	table of content
#1.  show tables cal and btc by grab query and add it to mysql.txt  	[works]
#2.  remove mysql.txt							[works]
#3.  help menu 								[works]
#4.  option to add to table btc						[works]
#5.  option to add to table cal						[works]
#6.  option to update btc 						[works-works, show after update]
#7.  option to delete from table btc					[works]
#8.  option to delete from table cal					[works]
#9.  hidden menu reset database						[works]
#10. substracting/add/div/mul two numbers from database			[works]
#11. tell you your profits						[works]
#12. hidden menu using mysql to do math					[works]
#13. get values from table						[codes]

#	variables
mysql_gdax="mysql -D gdax"

	

#10. substracting/add two numbers from database : my btc d1 id -[sub/add] cal b1 id	
if [ $# -eq 7 ]
then
	value1=$($mysql_gdax -e "select $2 from $1 where n=$3;" | tail -n 1)	#run the lines in bash and store it into value1
	value2=$($mysql_gdax -e "select $6 from $5 where n=$7;" | tail -n 1)	#run the lines in bash and store it into value1
	if [ $4 == "-sub" ]
	then
		mysql -e "select $value1-$value2;"
		exit 0
	fi
	if [ $4 == "-add" ]
	then
		mysql -e "select $value1+$value2;"
		exit 0
	fi
	if [ $4 == "-div" ]
	then
		mysql -e "select $value1/$value2;"
		exit
	fi
	if [ $4 == "-mul" ]
	then
		mysql -e "select $value1*$value2;"
		exit
	fi
	exit 0
fi

if [ $# -eq 5 ]
then
	if [ $1 == "-btc" ]
	then
		if [ $2 == "-update" ] || [ $2 == "-u" ] #6. option to update btc
		then
			#if updating close use: $0 -btc -update closed \'2020-01-04\' 5
			mysql -D gdax -e "update btc set $3=$4 where n=$5"
			exit 0
		else 	#4. option to add to table btc
			#use  $0 -btc 7444.15 50 0.25 0.00123456
			#echo "$mysql_gdax -e insert into btc (a1,b1,c1,d1) value ($2,$3,$4,$5);"
			$mysql_gdax -e "insert into btc (a1,b1,c1,d1) value ($2,$3,$4,$5);"
			exit 0
		fi
	fi
fi

#13. get values from table | my btc -get d1 id -> returns string
if [ $# -eq 4 ]
then
	if [ $2 == "-get" ]
	then
		getvalue=$($mysql_gdax -e "select $3 from $1 where n=$4;" | tail -n 1) 
		echo $getvalue
		exit 0
	fi
fi
if [ $# -eq 3 ] #5. option to add to table cal
then
	if [ $1 == "-cal" ]
	then
		if [ $2 == "-delete" ] || [ $2 == "-d" ] #8. option to delete from table cal	
		then
			$mysql_gdax -e "delete from cal where n=$3;"
			#my -cal -delete 3 
			exit 0
		fi
		mysql -D gdax -e "insert into cal (p1,s1) value ($2,$3);"
		exit 0
	fi
	if [ $1 == "-btc" ]
	then
		if [ $2 == "-delete" ] || [ $2 == "-d" ] #7. option to delete from table btc	
		then
			$mysql_gdax -e "delete from btc where n=$3;"
			exit 0
		fi
	fi
	#12. hidden menu using mysql to do math	: my 3 + 4 or my 3 \* 4
		mysql <<< "select $1 $2 $3;"
		exit 0
fi


if [ $# -eq 2 ]
then 
	if [ $1 == "-show" ] || [ $1 == "-s" ]
	then
		if [ $2 == "-all" ] || [ $2 == "-a" ] 
		then
			echo -e " \t \t \t \t \t cal table " > ./mysql.txt
			mysql gdax -e "select * from cal;" >> ./mysql.txt 
			echo -e " \t \t \t \t \t btc table" >> ./mysql.txt
			mysql gdax -e "select * from btc;" >> ./mysql.txt 
			more ./mysql.txt | column -ts $'\t'
			rm ./mysql.txt #2. remove mysql.txt
			exit 0
		fi
		if [ $2 == "-closed" ] || [ $2 == "-c" ]
		then
			echo -e " \t \t \t \t \t btc table" > ./mysql.txt
			mysql gdax -e "select * from btc where closed is not null;" >> ./mysql.txt 
			more ./mysql.txt | column -ts $'\t'
			rm ./mysql.txt
			exit 0
		fi
		if [ $2 == "-sort" ] || [ $2 == "-s" ]
		then
			echo -e " \t \t \t \t \t btc table" > ./mysql.txt
			mysql gdax -e "select * from btc where closed is null order by a1 asc;" >> ./mysql.txt
			more ./mysql.txt | column -ts $'\t'
			rm ./mysql.txt
                      	exit 0
		fi
		exit 0
	fi
fi

if [ $# -eq 1 ]
then
	if [ $1 == "-profits" ] || [ $1 == "-p" ] #11. tell you your profits	
	then
		#keeping as round for now but check later to see if truncate works better
		$mysql_gdax -e "select ROUND(SUM(e1),2) from btc;"	
		#$mysql_gdax -e "select truncate(SUM(e1),2) from btc;"
		exit 0
	fi	
	if [ $1 == "-reset" ] #9. hidden menu reset database
	then
		#backing up data
		$mysql_gdax -e "select * from btc;" > /root/Desktop/btc-$(date +%F)-$(date +%T).sql
		$mysql_gdax -e "select * from cal;" > /root/Desktop/cal-$(date +%F)-$(date +%T).sql 
		$mysql_gdax -e "delete from btc;"
		$mysql_gdax -e "ALTER TABLE btc AUTO_INCREMENT=1;"
		$mysql_gdax -e "delete from cal;"
		$mysql_gdax -e "ALTER TABLE cal AUTO_INCREMENT=1;"
		echo "database reseted"
		exit 0
	fi
fi	

#3. help menu
if [ $# -eq 1 ] && [ $1 == "-h" ]
then
	help_menu "$0 -btc"
	echo -e "my -btc -update variable value id_number \t example: my -btc -update a2 7444.15 5"	#need -e to output tab in echo. enables interpretation of backslash escapes.
	echo -e "my -btc price_bought_at dollars_spent fee_at_bought btc_earned \t example: my -btc 7444.15 50 0.25 0.00123456"
	echo -e "my -btc -delete id_number \t example: my -btc -delete 5"
	echo -e "my -cal trade_price spending_cost \t example: my -cal 7444.15 50"
	echo -e "my -cal -delete id_number \t example: my -cal -delete 5"
	echo -e "my btc column id add/sub/div/mul table column id \t example: my btc d1 25 -sub cal b1 30"
	echo -e "my [btc/cal] -get column id \t example: my btc -get d1 35"
	echo "my -show"
	echo -e "my -show -[all/closed/sort] \t example: my -s -c"
	exit 0
elif [ $# -eq 1 ] && [ $1 == "-show" ] || [ $1 == "-s" ] #1. grab query and add it to mysql.txt #need $# -eq 1 or else a blank $0 causes an error because it will look for $1 when one doesn't exist
then
	echo -e " \t \t \t \t \t cal table " > ./mysql.txt
	mysql gdax -e "select * from cal;" >> ./mysql.txt 
	echo -e " \t \t \t \t \t btc table" >> ./mysql.txt
	mysql gdax -e "select * from btc where closed is NULL;" >> ./mysql.txt 
	more ./mysql.txt | column -ts $'\t'
	rm ./mysql.txt #2. remove mysql.txt
else	#will always get triggered
	echo "try: $0 -h"
fi

#add how to add into cal;
#add how to add into btc;

#	This is can also work but I want the output to look better than using column -ts $'\t'
#sellhacks.com : run query from bash script or linux command line
#mysql -D gdax <<EOF	#this can be anything like <<MY_QUERY it is like a delimiter to tell the sell that you are going to enter multi-lines
#select * from btc;
#select * from cal;
#EOF
#	help_menu "$0 | column -ts $'\\\t'"

#if you want to use mysqldump: mysqldump gdax cal > file_name.sql
