#!/bin/bash
cd /usr/share/intel/hil_suite/
./start_hil_server.sh
sleep 1
clear
run_type=$(cat ~/Tools/CLA/config/tc_flow_control.properties | grep 'run_type')
run_type1=$(cat ~/Tools/CLA/config/tc_flow_control.properties | grep ${run_type%.*}.value)
echo ${run_type##*=}: ${run_type1##*=}
CRCC=$(cat ~/Tools/CLA/config/tc_flow_control.properties | grep 'CRCC')
CRCC1=$(cat ~/Tools/CLA/config/tc_flow_control.properties | grep ${CRCC%.*}.enable)
echo ${CRCC##*=}: ${CRCC1##*=}
printf "\nDo u want to open CLA change TC_Flow_control? y/n \n"
read answer
if [ $answer = 'y' ]
then 
	cd ~/Desktop
	./unlock.sh
fi




