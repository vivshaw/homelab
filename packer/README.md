# Packer config

Packer is used to create VM images that will be deployed onto the Proxmox cluster. Rather than deploy them directly, we use Packer to crete the VM templates, then we provision those VMs [with Terraform](../terraform/README.md).

All machine images are based on Ubuntu Server Jammy. [cloud-init](https://cloud-init.io/) and [Ansible](https://www.ansible.com/) are used to configure the images- see [the cloud-init user-data here](./ubuntu-hashistack/http/user-data) and [the Ansible config here](../ansible/README.md). Current machine images include:

- **ubuntu-hashistack**, an Ubuntu Server Jammy box with the Hashicorp stack (Nomad, Consul, and Vault)

## Running

You'll need to first spin up a Proxmox cluster, then provide its auth credentials in `credentials.pkrvars.hcl`. Then, to create the images:

```sh
cd ubuntu-hashistack
packer init
packer build -var-file ../credentials.pkrvars.hcl .
```

If you've already run this, and wish to re-create the templates after some changes, you need to remove the templates from Proxmox before rerunning. You can do that automagically with [delete-vm-templates](../bin/delete-vm-templates).

## Miscellany

See [`NOTES.md`](./NOTES.md) for miscellaneous notes and learnings I ran across along the way.
