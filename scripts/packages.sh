#!/bin/bash
#yum update -y

cat <<EOF >/etc/environment
LANG=en_US.utf-8
LC_ALL=en_US.utf-8
EOF

echo "devops ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/devops
mkdir /home/devops/.ssh
chmod 0700 /home/devops/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkR7lIQcZKgPYyuAfbAsxcqkr6Cb8oqMdyC7/awAoYUylhjdosap7RifUpu5v2Dc4SG/Wyu1WlR5mN4MV6iCNvJMX4LKS+rt0tVM1GUWbfQglCQO5DKq9mlBAp94/ckB5cl0nNPJ6wSLPsfNM2QNYFBYlZOp80cLpmYD22xKGURmr6ODgcRwUBkSVAeIch0rsL5hNX9CbmlW9bzqvtMJ0V1leK9+3wV9lsRSaLULK9Jpx61/r1fP9tOdiX7cj/n0KxaaaGMzCYELxlDocmcIkky7CU/EcqWKDSqzYuRQt2vFjVo/mFYB86DIYgR6bm7zXw2gBbzkcSm5zhhh6O6I7b" >> /home/devops/.ssh/authorized_keys
chmod 0600 /home/devops/.ssh/authorized_keys
chown -R devops:devops /home/devops/.ssh

echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf

# Force logs rotate and remove old logs
/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/rm -f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda

# Truncate the audit logs
#/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby

# Remove udev persistent rules
/bin/rm -f /etc/udev/rules.d/70*

# Remove mac address and uuids from any interface
/bin/sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-*

# Clean /tmp
/bin/rm -rf /tmp/*
/bin/rm -rf /var/tmp/*

# /bin/rm -f /root/
# Remove ssh keys
/bin/rm -f /etc/ssh/*key*

# Remove root's SSH history and other cruft
/usr/bin/sed -i "s%#PermitRootLogin yes%PermitRootLogin no%g" "/etc/ssh/sshd_config"
/bin/rm -rf ~root/.ssh/
/bin/rm -f ~root/anaconda-ks.cfg

# Remove root's and users history
/bin/rm -f ~root/.bash_history
/bin/rm -f /home/*/.bash_history
unset HISTFILE
