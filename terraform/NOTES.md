# Notes

- Getting "VM already running" errors with the Proxmox provider? [Ensure `iothread` is not set](https://github.com/Telmate/terraform-provider-proxmox/issues/460)
- Can't shrink disk size when cloning a template! Make sure that the Packer image supports a disk size no larger than what you actually intend to use.
- If your TF stuff doesn't match the VM template in some aspects, the VM template will win. This will result in a deployed state that doesn't match TF state. I ran into this with `desc` and `disk -> type`.
