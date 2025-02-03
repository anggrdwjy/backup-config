#!/usr/bin/expect -f

set username "Username"
set password "Password"
set devices [open "/home/ip-backup-router.txt"]
set date [clock format [clock seconds] -format {%d%m%Y-%T}]

while {[gets $devices device] !=-1} {
        spawn ssh -o StrictHostKeyChecking=no -l $username $device
        expect "password: "
        send "$password\n"
        log_file -noappend $device-$date.log
        expect "$ "
        send "terminal length 0\n"
        send "show run\n"
        expect "$ "
        send "exit\r"
        log_file
        }
close $devices
