#!/bin/bash
cd ~/Tools/CLA/logs
chmod -R 777 *
find . -name "*.bin" -exec rm -rf {} \;
time=`date +%Y%m%d`
printf "\n"
if test ${#1} -eq 8
then
	printf "infor===>script will delete logs and CD before $1 \n\n"
	sleep 2
	for dir in `ls -d ST_*`
	do
		if test ${dir:8:8} -lt $1
		then	
			printf "${dir}\n"
			rm -rf ~/Tools/CLA/logs/${dir}
		fi	
	done
	cd /mnt/trace-server/CC/ICE7360
	for dir1 in `ls CD_*`
	do
		time1=${dir1:3:4}${dir1:8:2}${dir1:11:2}${dir61:14:2}
		if test ${time1} -lt $1
		then
			printf "${dir1}\n"
			rm ${dir1}
		fi
	done
	df|grep -i /dev/dm-1
	df|grep -i /dev/mapper
	printf "infor===>Done!!!\n"
else
	printf "ERROR===>please input right date format, e.g.20161118 \n\n"
fi
