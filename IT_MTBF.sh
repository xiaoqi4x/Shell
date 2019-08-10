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
expect "*$*" {send "cd /harts/packages\r"}

expect "*$*" {send "sudo wget -4 -e use_proxy=no -N http://isscorp.intel.com/IntelSM_BigFix/33570/package/scan/labscanaccount.sh\r"}
expect { 
        "*pass*" {send "${password}\r";}
        "*$*" {send "\r";}
}
expect "*$*" {send "sudo chmod 777 labscanaccount.sh\r"}
expect "*$*" {send "sudo ls -l labscanaccount.sh\r"}
expect "*$*" {send "sudo getent passwd | grep sys_cert\r"}

expect "*$*" {send "sudo ./labscanaccount.sh\r"}
expect "*$*" {send "sudo getent passwd | grep sys_cert\r"}

expect "*$*"
send "hostname\r"
send "exit\r"
expect eof