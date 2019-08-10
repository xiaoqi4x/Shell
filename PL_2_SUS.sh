#!/bin/bash



cat list_SUS.txt | while read hostname nvm
do
echo "---------------------------------------------"
echo "|||| Start to do: $hostname "
echo "---------------------------------------------"
#./Modify_CLA.sh $hostname
./Change_NVM.sh $hostname $nvm
done
exit 0
