# 2025_podman_iptable_rules

Experiments about applying iptable rules to a podman container.

The goal is to put iptable or similar firewall rules in the network namespace of a podman container, so that it is possible to fine grained firewall containers individually.

Most tests and implementations are based on discussions from: https://github.com/containers/podman/discussions/27099 .

## Status

This seems to be working :) .

