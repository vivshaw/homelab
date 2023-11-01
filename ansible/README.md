# Ansible config

[Ansible](https://www.ansible.com/) is used to do some configuration of the VMs and VM templates. It doesn't handle _all_ of it- I try to bake as much as possible into the the VM images using [cloud-init](https://cloud-init.io/). Ansible handles these things:

- **on the base VM image**, as a Packer provisioner:
  - some [post-cloud-init cleanup](./tasks/cleanup.yml)
  - [installing the Hashicorp stack](./tasks/hashistack.yml)
- **on the provisioned VMs**, as a Terraform provisioner:
  - _eventually_, configuring Nomad, Consul, and Vault to do what I need 'em to

## Running

You should never need to run Ansible manually- these playbooks are exclusively handled by Packer and Terraform provisioners. A good ol' `packer build` or `terraform apply` should do it all automagically!
