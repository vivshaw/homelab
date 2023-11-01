# Notes

- Getting "VM already running" errors with the Proxmox provider? [Ensure `iothread` is not set](https://github.com/Telmate/terraform-provider-proxmox/issues/460)
- Can't shrink disk size when cloning a template! Make sure that the Packer image supports a disk size no larger than what you actually intend to use.
- If your TF stuff doesn't match the VM template in some aspects, the VM template will win. This will result in a deployed state that doesn't match TF state. I ran into this with `desc` and `disk -> type`.
- the Terraform Proxmox provisioner [has some race conditions](https://github.com/Telmate/terraform-provider-proxmox/issues/23)- you'll know this is happening when Terraform tries to assign duplicate VM ids. safest way to ensure all `apply`/`destroy`s work is to turn off parallelism with `pm_parallel = 1`. sadly, this makes provisioning take _forever_, but 🤷
- flaky timeout problems may or may not be lessened by lengthening the default timeout with the `PM_TIMEOUT` env var- I have it at `600` (5 minutes)
- If you set the wrong gateway in `ipconfig0`, your machine template will have network when Packer is building it, but your machines won't after you provision 'em with Terraform.
- [full vs. linked clones](https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_copy_and_clone)- if you do full clones of 12 big ol' VMs, you _will_ take forever, spike IO delay to infinity, and fail provisioning. `full_clone = false` keeps it snappy.
