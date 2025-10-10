#!/bin/bash

echo "Start set_iptable_rules_denyall.sh hook"

# Block all incoming and outgoing traffic
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Log the applied rules (optional, for debugging)
echo "Applied iptables rules:"
iptables -L -v
