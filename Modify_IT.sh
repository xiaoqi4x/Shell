#!/bin/bash
#This script is using for add Mac UTT server SSH key, author: chaox.c.liu@intel.com  2018-09-07


cat list.txt | while read hostname
do
echo "---------------------------------------------"
echo "|||| Start to do: $hostname "
echo "---------------------------------------------"
./IT_MTBF.sh $hostname
done
exit 0
