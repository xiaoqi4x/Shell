#!/usr/bin/expect


if {$argc < 1} {
    #do something
    send_user "usage: $argv0 <hostname>"
    exit
}

set hostname [lindex $argv 0]
set UTT [lindex $argv 1]
set GNSS [lindex $argv 2]
#set password_hcloud 123poi
set timeout -1
spawn ssh chaoliux@${hostname}
expect {
	"*assword*" {send "invent@0515\r";}
	"*yes/no*" {send "yes\r";exp_continue}
}

expect "*$*" {send "hostname\r"}
expect "*$*" {send "uptime\r"}
expect "*$*" {send "su - hcloud\r"}
expect "*$*" {send "pwd\r"}

expect "*$*" {send "ssh-keygen -t rsa -b 2048\r"}
expect "*ssh/id_rsa*" {send "\r"}
expect {
	"*passphrase*" {send "\r";}
	"*y/n*" {send "y\r";exp_continue}
	}
expect "*again*" {send "\r"}

expect "*$*" {send "cd ~/.ssh\r"}
expect "*$*" {send "rm ~/.ssh/known_hosts\r"}

#start to add UTT SSH key
expect "*$*" {send "ssh-copy-id hcloud@${UTT}.bj.intel.com\r"}
expect {
        "*assword*" {send "Intel1234!\r";}
        "*yes/no*" {send "yes\r";exp_continue}
	}
expect "*$*" {send "ssh-keyscan –H -t rsa ${UTT}.bj.intel.com\r"}
expect "*$*" {send "ssh-keyscan –H -t rsa ${UTT}.bj.intel.com >>known_hosts\r"}		
expect "*$*" {send "ssh-keyscan -t rsa ${UTT}.bj.intel.com\r"}
expect "*$*" {send "ssh 'hcloud@${UTT}.bj.intel.com'\r"}
expect "*hcloud$*" {send "hostname\r"}
expect "*hcloud$*" {send "exit\r"}

#start to add GNSS SSH key
expect "*$*" {send "ssh-copy-id hcloud@${GNSS}.bj.intel.com\r"}
expect {
        "*assword*" {send "Intel1234!\r";}
        "*yes/no*" {send "yes\r";exp_continue}
	}
expect "*$*" {send "ssh-keyscan –H -t rsa ${GNSS}.bj.intel.com\r"}
expect "*$*" {send "ssh-keyscan –H -t rsa ${GNSS}.bj.intel.com >>known_hosts\r"}		
expect "*$*" {send "ssh-keyscan -t rsa ${GNSS}.bj.intel.com\r"}
expect "*$*" {send "ssh 'hcloud@${GNSS}.bj.intel.com'\r"}
expect "*hcloud$*" {send "hostname\r"}
expect "*hcloud$*" {send "exit\r"}

#logout 
expect "*$*"
send "hostname\r"
send "exit\r"
send "exit\r"
expect eof
