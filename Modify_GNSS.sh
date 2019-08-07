#!/usr/bin/expect
#This script is using for add Mac UTT server SSH key, author: chaox.c.liu@intel.com  2018-09-07

if {$argc < 1} {
    #do something
    send_user "usage: $argv0 <hostname>"
    exit
}

set hostname [lindex $argv 0]
set old_GNSS [lindex $argv 1]
set new_GNSS [lindex $argv 2]
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

#Modify GNSS IP address in /harts/config/cla/tc_flow_control.properties
expect "*$*" {send "sed -i 's/${old_GNSS}/${new_GNSS}/g' /harts/config/cla/tc_flow_control.properties\r"}
expect "*$*" {send "cat /harts/config/cla/tc_flow_control.properties | grep ${old_GNSS}\r"}
expect "*$*" {send "cat /harts/config/cla/tc_flow_control.properties | grep ${new_GNSS}\r"}

#config SSH key environment
expect "*$*" {send "su - hcloud\r"}
expect "*$*" {send "cd ~/.ssh\r"}
expect "*$*" {send "pwd\r"}

expect "*$*" {send "ssh-keygen -t rsa -b 2048\r"}
expect "*ssh/id_rsa*" {send "\r"}
expect "*y/n*" {send "n\r"}

####################################################
#expect {
#	"*passphrase*" {send "\r";}
#	"*y/n*" {send "n\r";exp_continue}
#	}
#expect "*again*" {send "\r"}
#expect "*$*" {send "cd ~/.ssh\r"}
#expect "*$*" {send "rm ~/.ssh/known_hosts\r"}
####################################################

#start to add new_GNSS SSH key
expect "*$*" {send "ssh-copy-id hcloud@${new_GNSS}.bj.intel.com\r"}
expect {
        "*assword*" {send "Intel1234!\r";}
        "*yes/no*" {send "yes\r";exp_continue}
	}
expect "*$*" {send "ssh-keyscan –H -t rsa ${new_GNSS}.bj.intel.com\r"}
expect "*$*" {send "ssh-keyscan –H -t rsa ${new_GNSS}.bj.intel.com >>known_hosts\r"}		
expect "*$*" {send "ssh-keyscan -t rsa ${new_GNSS}.bj.intel.com\r"}
expect "*$*" {send "ssh 'hcloud@${new_GNSS}.bj.intel.com'\r"}
expect "*hcloud$*" {send "hostname\r"}
expect "*hcloud$*" {send "exit\r"}

#logout 
expect "*$*"
send "hostname\r"
send "exit\r"
send "exit\r"
expect eof
