# Notes

- Boot command getting tyoed wrong? [Adjust `boot_key_interval`](https://github.com/hashicorp/packer/issues/2933)
- [Use single quotes or escape ';' in `boot_command`](https://askubuntu.com/a/1329415), otherwise autoinstall will silently fail
- If running from WSL, make sure that:
  - you've chosen a specific port or range of ports for Packer
  - that port or range is [proxied to WSL](https://stackoverflow.com/questions/61002681/connecting-to-wsl2-server-via-local-network)
  - and, that port or range is opened in Windows Firewall
