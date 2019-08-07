#!/bin/bash
cd ~/harts/logs/test_sets/
chmod -R 777 *
find . -name "*.bin" -exec rm -rf {} \;
time=`date +%Y%m%d`
clear
df|grep -i /dev/dm-1
df|grep -i /dev/mapper
printf "\nDo u want to delete logs from ~/harts/logs/test_sets/  y/n?\n"
read answer
if [ $answer = 'y' ]
then 
	ls -l
	printf "\ninput the date which u want to delete(e.g.0122): "
	read date1
	if test ${#date1} -eq 4 
	then
		if test ${date1:0:1} -lt 2
		then
			if test ${date1:2:1} -lt 4
			then
				printf "infor===>script will delete logs and CD before ${date1} \n\n"
				for dir in `ls -l | awk '{print $6 $7 $9}'`
				do
					if test ${#dir} -eq 12
					then	
						#printf "${dir:0:3}  ${dir:3:1}  ${dir:4:8}\n"
						dir1=${dir:0:3}  dir2=${dir:3:1}  dir3=${dir:4:8}
					fi
					if test ${#dir} -eq 13
					then	
						#printf "${dir:0:3}  ${dir:3:2}  ${dir:5:8}\n"
						dir1=${dir:0:3}  dir2=${dir:3:2}  dir3=${dir:5:8}
					fi
					case "$dir1" in
					Jan)
						dir4=01${dir2};;
					Feb)
						dir4=02${dir2};;
					Mar)
						dir4=03${dir2};;
					Apr)
						dir4=04${dir2};;
					May)
						dir4=05${dir2};;
					Jun)
						dir4=06${dir2};;
					Jul)
						dir4=07${dir2};;
					Aug)
						dir4=08${dir2};;
					Sep)
						dir4=09${dir2};;
					Oct)
						dir4=10${dir2};;
					Nov)
						dir4=11${dir2};;
					Dec)
						dir4=12${dir2};;
					*);;
					esac
					if test ${dir4} -lt ${date1}
					then
						#printf "${dir3}    ${dir4}\n"
						rm -R ${dir3}
					fi
			
				done
				clear
				ls -l
				df|grep -i /dev/dm-1
				df|grep -i /dev/mapper

			else
				printf "ERROR===>please input right date!!! \n\n"
			fi
		else
			printf "ERROR===>please input right date!!! \n\n"
		fi
	else
		printf "ERROR===>please input right date format, e.g.0122 \n\n"
	fi
fi

