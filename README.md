# homelab

@vivshaw's private homelab. Currently, it consists of a fleet of VMs provisioned on a 3-machine Proxmox cluster using Packer and Terraform.

## Roadmap

- [ ] Overall: Set up script to check deps & run tools automagically
- [ ] Overall: Get TLS working
- [ ] Overall: Modularize more, less Ctrl+C Ctrl+V
- [ ] Packer: Swap from password to token auth
- [ ] Packer: Get SSH auth set up, then disable password auth
- [ ] Packer: Provide convenience tools- exa, bat, byobu?
- [ ] Packer: Provide a script to autoremove existing images
- [ ] Proxmox: Configure metal? Provide same suite of convenience tools as VMs on the cluster machines, if possible

## Acknowledgements

- https://github.com/kencx/homelab/tree/master
- https://github.com/N7KnightOne/packer-template-debian-11
- https://github.com/ChristianLempa/boilerplates/
