# homelab

This is "the Magi System", @vivshaw's homelab. Currently, it consists of a fleet of VMs provisioned on a 3-physical-machine Proxmox cluster using Packer and Terraform. The end goal is to get the full Hashicorp stack up & running, then deploy some useful self-hosed apps onto the Nomad cluster. I'm not quite there yet!

## Physical specs

The Magi System's physical infrastructure is a 3-node cluster and a switch.

### Nodes

3 physical nodes exist. All are Lenovo M Tiny series mini-PCs, models [M900 Tiny](https://www.lenovo.com/il/en/desktops-and-all-in-ones/thinkcentre/m-series-tiny/M900-Tiny/p/11TC1MTM900) or [M910q Tiny](https://www.lenovo.com/us/en/p/desktops/thinkcentre/m-series-tiny/thinkcentre-m910q/11tc1mt910q). All are specced with 8-core i7-6700T CPUs, 32G RAM, and 1TB SSD. The nodes are:

- **casper** - an M900, at 192.168.1.123
- **balthasar** - an M910q, at 192.168.1.124
- **melchior** - an M910q, at 192.168.1.125

### Switch

The switch is a [Netgear GS308E](https://www.netgear.com/business/wired/switches/plus/gs308e/) smart switch, configured to do absolutely nothing fancy at this time.

## Getting started

You'll need to provision a Proxmox API token, then provide these enviroment variables in order for most of the tools and scripts to work:

```sh
export TF_VAR_proxmox_api_url="https://example.com:8006/api2/json"
export TF_VAR_proxmox_api_token_id="example@realm!token-id"
export TF_VAR_proxmox_api_token_secret="some-example-uuid"
```

## Roadmap

- [ ] Overall: Set up script to check deps & run tools automagically
- [ ] Overall: Get TLS working
- [ ] Overall: Tighten up token perms
- [ ] Overall: Use Vault or something to provide secrets
- [ ] Overall: Single source of truth for physical machine info- hostnames, canonical order, VM template ID, etc.
- [ ] Terraform: Actually configure the Vault & Consul machines, and do the Nomad cluster config
- [ ] Ansible: Find a nicer way to organize the Ansible stuff, once there's more of it
- [ ] Ansible: Pull more, _ideally_ all, of the base VM image configuration into `cloud-init`. That way, the base image can be immutable, and Ansible can be used only for provision-time config.
- [ ] Packer: Provide convenience tools- exa, bat, byobu? nice ZSH config?
- [ ] Proxmox: Configure metal? Provide same suite of convenience tools as VMs on the cluster machines, if possible

## Acknowledgements

- https://github.com/kencx/homelab/tree/master
- https://github.com/N7KnightOne/packer-template-debian-11
- https://github.com/ChristianLempa/boilerplates/
