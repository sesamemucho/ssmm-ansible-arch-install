#!/usr/bin/expect -f
#
# The Arch RPi image doesn't have Python, which
# is needed by ansible.
spawn ssh -o IdentitiesOnly=yes alarm@10.135.155.154
expect "password: "
send "alarm\r"
expect "$ "
send "su -\r"
expect "Password: "
send "root\r"
expect "# "
send "pacman-key --init\r"
expect "# "
send "pacman-key --populate archlinuxarm\r"
expect "# "
send "pacman --noconfirm -S python\r"
expect "# "
send "exit\r"
