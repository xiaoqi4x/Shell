#!/usr/bin/expect
#This script is using for add Mac UTT server SSH key, author: chaox.c.liu@intel.com  2018-09-07

if {$argc < 1} {
    #do something
    send_user "usage: $argv0 <hostname>"
    exit
}

set hostname [lindex $argv 0]
set UTT [lindex $argv 1]
set GNSS [lindex $argv 2]
set user chaoliux
set password invent@0515
#./GNSS_add_UTT_MTBF.sh ${hostname} ${UTT} ${GNSS}

set timeout -1
spawn sftp ${user}@${hostname}
expect {
	"*assword*" {send "${password}\r";}
	"*yes/no*" {send "yes\r";exp_continue}
}

expect "sftp>" {send "pwd\r"}
expect "sftp>" {send "lcd /home/hcloud/MTBF/harts_nodes\r"}
expect "sftp>" {send "lpwd\r"}
expect "sftp>" {send "put *.sh\r"}
expect "sftp>" {send "put *.zip\r"}
expect "sftp>" {send "ls -l\r"}

expect "sftp>" {send "mkdir /harts/config/cla\r"}
expect "sftp>" {send "mkdir /harts/config/NVM_DATA\r"}
expect "sftp>" {send "mkdir /harts/config/NVM_DATA_BACKUP\r"}

expect "sftp>" {send "cd /harts/config/cla\r"}
expect "sftp>" {send "pwd\r"}
expect "sftp>" {send "lcd /home/hcloud/MTBF/harts_nodes/${hostname}\r"}
expect "sftp>" {send "lpwd\r"}
expect "sftp>" {send "mput *.properties\r"}
expect "sftp>" {send "ls -l\r"}

expect "sftp>" {send "cd /harts/config/NVM_DATA\r"}
expect "sftp>" {send "pwd\r"}
expect "sftp>" {send "lcd /home/hcloud/MTBF/harts_nodes/${hostname}/NVM\r"}
expect "sftp>" {send "lpwd\r"}
expect "sftp>" {send "mput -r *\r"}
expect "sftp>" {send "ls -l\r"}

expect "sftp>" {send "cd /harts/config/NVM_DATA_BACKUP\r"}
expect "sftp>" {send "pwd\r"}
expect "sftp>" {send "lpwd\r"}
expect "sftp>" {send "mput -r *\r"}
expect "sftp>" {send "ls -l\r"}

expect "sftp>" {send "ls -l /harts/config/*\r"} 
expect "sftp>" {send "bye\r"}
expect eof

#check configuration
spawn ssh ${user}@${hostname}
expect {
        "*assword*" {send "${password}\r";}
        "*yes/no*" {send "yes\r";exp_continue}
}

expect "*$*" {send "chmod 777 BlackRay_flash.sh\r"}
expect "*$*" {send "ls -lR\r"}

expect "*$*" {send "sudo ./BlackRay_flash.sh\r"}
expect { 
        "*pass*" {send "${password}\r";}
        "*$*" {send "\r";}
}
expect "*$*" {send "sudo /harts/current/imc_ipc*/ipc_config\r"}
expect "*$*" {send "sudo /harts/current/imc_ipc*/imc_start_at\r"}
expect "*$*" {send "sudo /harts/current/imc_ipc*/gate /dev/iat\r"}
expect {
		"*XCMSRSI*" {send "at+cpin?\r";}
		"*PBREADY*" {send "at+cpin?\r";}
}
expect {
		"*OK*" {send "at\r";}
		"*ERROR*" {send "at\r";}
}
expect "*OK*" {send "\003"}

expect "*$*" {send "sudo chmod 775 -R /harts/config/*\r"}
expect "*$*" {send "sudo chown -R hcloud:sst_users /harts/config/*\r"}
expect "*$*" {send "ls -lR /harts/config\r"}


expect "*$*"
send "hostname\r"
send "exit\r"
expect eof
