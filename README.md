# 2025_podman_iptable_rules

Experiments about applying iptable rules to a podman container.

The goal is to put iptable or similar firewall rules in the network namespace of a podman container, so that it is possible to fine grained firewall containers individually. Once this is set and the container runs, the container should not be able to change these rules. Basically, this is an additional layer of security / containment: a container should only have network access if it needs to, and should only be able to contact IPs it has a reason to contact. This is just one additional step to limit the impact of e.g. a vulnerability in a container or a container that is under supply chain attack: the container should only be allowed to contact IPs that the user trusts anyways.

Most tests and implementations are based on discussions from: https://github.com/containers/podman/discussions/27099 .

## How this works

The way the indirection / chain of actions works:

- iptable (or any other firewalling rules or any other kind of bash scripts for that matter) scripts are available at https://github.com/jerabaul29/2025_podman_iptable_rules/blob/main/set_iptable_rules_denyall.sh and similar files.
- these scripts are listed in hooks, e.g. https://github.com/jerabaul29/2025_podman_iptable_rules/blob/main/hooks/my_iptables_hook_denyall.json and similar.
- when using `podman run` with annotation that matches the hooks `when` conditions https://github.com/jerabaul29/2025_podman_iptable_rules/blob/main/podman_run_with_hooks.sh , the hooks are run and apply the rules.

The way the firewalling is applied in rootless mode (disclaimer: I am not a podman expert):

- when using `podman run`, a new namespace is created by the command for the container and everything it needs, including network; all of this is built using linux OS capabilities inside the new namespace
- the hook is run after these namespaces are created and the network is set, effectively applying the firewalling rules inside the container network namespace, to the container network - at this stage, the capability `CAP_NET_ADMIN` is enabled, so any network setup action can be performed
- once the hooks is run and the environment for the container is set up, in rootless mode and using default, the `CAP_NET_ADMIN` is dropped and the container itself gets started
- this means that now the container is running, with its own network in its namespace configured and firewalled, while the container itself has dropped `CAP_NET_ADMIN` so that it cannot any longer modify its own network rules, firewalling, etc. In practice, this means that the container has been firewalled and cannot break out.

The limitations:

- this will only contain the container in rootless mode, when the container has no `CAP_NET_ADMIN` capability; otherwise, the container itself has the authority to modify its own network configuration, including network configuration and firewallying. So make sure to use the right `podman run` command and arguments!
- See https://docs.podman.io/en/latest/markdown/podman-run.1.html ; you should in particular be careful to make sure that the container does not have additional `--cap-add` flags that breaks the confinement: https://docs.podman.io/en/latest/markdown/podman-run.1.html#cap-add-capability .

Going further:

- podman implements the OCI hooks standard; you can read more about this at the OCI standard definition and documentation, see for example https://github.com/opencontainers/runtime-spec/blob/main/config.md#createRuntime-hooks and related.

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
