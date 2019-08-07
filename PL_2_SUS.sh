#!/bin/bash
#This script is using for add Mac UTT server SSH key, author: chaox.c.liu@intel.com  2018-09-07


cat list_SUS.txt | while read hostname nvm
do
echo "---------------------------------------------"
echo "|||| Start to do: $hostname "
echo "---------------------------------------------"
#./Modify_CLA.sh $hostname
./Change_NVM.sh $hostname $nvm
done
exit 0
