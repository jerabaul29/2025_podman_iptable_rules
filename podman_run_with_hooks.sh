#!/bin/bash

# NOTE: add --log-level=debug for more info

# deny all
echo "----------------------------------------"
echo " > podman run with the hook that denies all traffic"
podman run --rm -it --annotation apply_iptables_denyall_hook=true --hooks-dir /home/jeanr/Desktop/Git/2025_podman_iptable_rules/hooks test_container_iptables

# deny all but allow some
echo ""
echo "----------------------------------------"
echo " > podman run with the hook that denies all traffic except to and from 1.1.1.1, which is allowed"
podman run --rm -it --annotation apply_iptables_denyall_allowsome_hook=true --hooks-dir /home/jeanr/Desktop/Git/2025_podman_iptable_rules/hooks test_container_iptables

