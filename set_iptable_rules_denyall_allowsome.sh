#!/bin/bash

echo "Start set_iptable_rules_denyall_allowsome.sh hook" > /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1

echo -n "whoami: " >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1
whoami >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1

# Block traffic to 8.8.8.8 but not other stuff
iptables -P INPUT DROP >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
iptables -P OUTPUT DROP >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
iptables -P FORWARD DROP >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
# allow traffic to and from 1.1.1.1 as an example
iptables -A INPUT -s 1.1.1.1 -j ACCEPT
iptables -A OUTPUT -d 1.1.1.1 -j ACCEPT

# Log the applied rules (optional, for debugging)
echo "Applied iptables rules:" >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1
echo -n "iptables -L -v: " >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1
iptables -L -v >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1

echo "Finished set_iptable_rules_denayll.sh hook" >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall_allowsome.log 2>&1

