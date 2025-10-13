# 2025_podman_iptable_rules

Experiments about applying iptable rules to a podman container.

The goal is to put iptable or similar firewall rules in the network namespace of a podman container, so that it is possible to fine grained firewall containers individually.

Most tests and implementations are based on discussions from: https://github.com/containers/podman/discussions/27099 .

## Status

This seems to be working :) .

Note that I wanted to have everything in a single folder so it is easy to clone and work with, and since hooks typically need fully qualified paths, this means I have hard-coded quite a few paths to non standard hook location etc. This assumes that the repo is cloned into `~/Desktop/Git`, i.e.

```
/Desktop/Git/2025_podman_iptable_rules [main|✔]> pwd
/home/jeanr/Desktop/Git/2025_podman_iptable_rules
```

and my username is `jeanr` - so to make things work, you may need to edit username (if you also clone in `~/Desktop/Git`), or the full paths if you use a different location. Not sure if there is a better way around when I want to keep all files in a folder and hooks etc typically live in some `/etc` or similar folders by default.

## Disclaimers

I am not a podman expert - this comes without guarantees. Feedback welcome!
