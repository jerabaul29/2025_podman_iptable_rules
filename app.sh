#!/bin/bash

# ----------------------------------------
# preamble

# exit if a command fails; to circumvent, can add specifically on commands that can fail safely: " || true "
set -o errexit
# make sure to show the error code of the first failing command
set -o pipefail
# do not overwrite files too easily
# to override the noclobber: >| instead of > only
set -o noclobber
# exit if try to use undefined variable
set -o nounset

# on globbing that has no match, return nothing, rather than return the dubious default ie the pattern itself
# see " help shopt "; use the -u flag to unset (while -s is set)
shopt -s nullglob

# ----------------------------------------

echo " > Start app.sh"

echo ""
echo " > Check capabilities: the container should not have (i.e either not present or explicitely disabled with !) the cap_net_admin capability; otherwise, it can change its own network rules, including changing iptable rules."
capsh --print
echo " > grep the cap and check it:"
capsh --print | grep --color=always -i !cap_net_admin

echo ""
echo " > Check that we cannot set and change iptables rules from within the container (as expected)"
iptables -P INPUT DROP && \
iptables -P OUTPUT DROP && \
iptables -P FORWARD DROP

echo ""
echo " > Check access to 8.8.8.8"
nc -w 3 -z 8.8.8.8 53

echo ""
echo " > Check access to 1.1.1.1"
nc -w 3 -z 1.1.1.1 53

echo ""
echo " > Check access to vg.no"
nc -w 3 -z vg.no 80

echo ""
echo " > End app.sh"
