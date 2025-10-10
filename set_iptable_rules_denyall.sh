#!/bin/bash

echo "Start set_iptable_rules_denyall.sh hook" > /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1

echo -n "whoami: " >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
whoami >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1

# Block all incoming and outgoing traffic
iptables -P INPUT DROP >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
iptables -P OUTPUT DROP >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
iptables -P FORWARD DROP >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1

# Log the applied rules (optional, for debugging)
echo "Applied iptables rules:" >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
echo -n "iptables -L -v: " >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
iptables -L -v >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1

echo "Finished set_iptable_rules_denayll.sh hook" >> /home/jeanr/Desktop/Current/mylogs/log_set_iptable_rules_denyall.log 2>&1
