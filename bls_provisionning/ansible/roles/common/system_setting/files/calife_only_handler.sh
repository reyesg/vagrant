#!/usr/bin/expect -f

set DEPLOYPWD "DePLoy462"

set NODEIP [lrange $argv 0 0]
set USERNAME admapp

puts -nonewline "Enter password for ${USERNAME}: "
flush stdout
set PWD [gets stdin]

spawn ssh ${USERNAME}@${NODEIP}

expect "(yes/no)?" { send -- "yes\r"; expect "password:" { send -- "${PWD}\r" } } \
"password:" { send -- "${PWD}\r" }

expect "${USERNAME}@"

send -- "calife\r"
expect "password" { send -- "${PWD}\r" }
expect "root@"

send -- "adduser  integration && echo -e \"${DEPLOYPWD}\n${DEPLOYPWD}\" | integration   integration && echo \"deploy    ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers\r"
expect "root@"

send "exit\r"

