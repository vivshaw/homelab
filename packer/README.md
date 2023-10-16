# Packer config

Packer is used to create VM images that will be deployed onto the Proxmox cluster. Rather than deploy them directly, we use Packer to crete the VM templates, then we provision those VMs [with Terraform](../terraform/README.md).

All machine images are based on Ubuntu Server Jammy. `cloud-init` is used to configure the machines. Current machine images include:

- **nomad-client**, a Nomad client

## Running

You'll need to first spin up a Proxmox cluster, then provide its auth credentials in `credentials.pkrvars.hcl`. Then, to create the images:

```sh
cd nomad-client
packer build -var-file ../credentials.pkrvars.hcl .
```

If you've already run this, and wish to re-create the templates after some changes, you currently need to manually remove the templates from Proxmox before rerunning.

## Miscellany

See [`NOTES.md`](./NOTES.md) for miscellaneous notes and learnings I ran across along the way.
