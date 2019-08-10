#!/usr/bin/expect


if {$argc < 1} {
    #do something
    send_user "usage: $argv0 <hostname>"
    exit
}

set hostname [lindex $argv 0]
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
expect "*$*" {send "sed -i 's/=+861053930024/=+861053945825/g' /harts/config/cla/cla.properties\r"}
#expect "*$*" {send "sed -i 's/=60845399/=+861060845399/g' /harts/config/cla/cla.properties\r"}
expect "*$*" {send "cat /harts/config/cla/cla.properties | grep 53930024\r"}
expect "*$*" {send "cat /harts/config/cla/cla.properties | grep 53945825\r"}
#expect "*$*" {send "cat /harts/config/cla/cla.properties | grep 60845399\r"}

#logout 
expect "*$*"
send "hostname\r"
send "exit\r"
send "exit\r"
expect eof
