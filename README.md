# homelab

@vivshaw's homelab. Currently, it consists of a fleet of VMs provisioned on a 3-machine Proxmox cluster using Packer and Terraform.

## Getting started

You'll need to provision a Proxmox API token, then provide these enviroment variables in order for most of the tools and scripts to work:

```sh
export PROXMOX_URL="https://example.com:8006/api2/json"
export PROXMOX_USER_AND_REALM="example@realm"
export PROXMOX_TOKEN_ID="example-token-id"
export PROXMOX_TOKEN="some-example-uuid"
```

## Roadmap

- [ ] Overall: Set up script to check deps & run tools automagically
- [ ] Overall: Get TLS working
- [ ] Overall: Tighten up token perms
- [ ] Overall: Use Vault or something to provide secrets
- [ ] Packer: Provide convenience tools- exa, bat, byobu?
- [ ] Packer: Provide a script to autoremove existing images
- [ ] Proxmox: Configure metal? Provide same suite of convenience tools as VMs on the cluster machines, if possible

## Acknowledgements

- https://github.com/kencx/homelab/tree/master
- https://github.com/N7KnightOne/packer-template-debian-11
- https://github.com/ChristianLempa/boilerplates/
