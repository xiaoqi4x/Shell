#!/bin/bash
#This script is using for add Mac UTT server SSH key, author: chaox.c.liu@intel.com  2018-09-07


cat harts_nodes_list.txt | while read hostname
do
echo "---------------------------------------------"
echo "|||| Start to do: $hostname "
echo "---------------------------------------------"
./Modify_CLA.sh $hostname
done
exit 0
