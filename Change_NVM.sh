#!/usr/bin/expect
#This script is using for add Mac UTT server SSH key, author: chaox.c.liu@intel.com  2018-09-07

if {$argc < 1} {
    #do something
    send_user "usage: $argv0 <hostname>"
    exit
}

set hostname [lindex $argv 0]
set nvm_number [lindex $argv 1]
set user chaoliux
set password invent@0515

set timeout -1
spawn ssh ${user}@${hostname}
expect {
	"*assword*" {send "${password}\r";}
	"*yes/no*" {send "yes\r";exp_continue}
}

expect "*$*" {send "hostname\r"}
expect "*$*" {send "uptime\r"}

#Update NVM data
expect "*$*" {send "cp -r /harts/config/NVM_DATA_BACKUP /harts/config/NVM_DATA_BACKUP_NOPolar\r"}
expect "*$*" {send "ls -l /harts/config/NVM_DATA_BACKUP_NOPolar\r"}

expect "*$*" {send "scp -r hcloud@pcie-desk28.bj.intel.com:/home/hcloud/MTBF/NVM/${nvm_number}/* /harts/config/NVM_DATA_BACKUP/\r"}
expect {
	"*assword*" {send "123poi\r";}
	"*yes/no*" {send "yes\r";exp_continue}
}
expect "*$*" {send "ls -l /harts/config/NVM_DATA_BACKUP\r"}

expect "*$*" {send "sudo chmod 775 -R /harts/config/*\r"}
expect {
	"*assword*" {send "${password}\r";}
	"*$*" {send "\r";}
}
expect "*$*" {send "sudo chown -R hcloud:sst_users /harts/config/*\r"}
expect "*$*" {send "ls -lR /harts/config/*\r"}

#logout 
expect "*$*"
send "hostname\r"
send "exit\r"
send "exit\r"
expect eof
