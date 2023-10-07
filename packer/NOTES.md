# Notes

- Boot command getting typed wrong? [Adjust `boot_key_interval`](https://github.com/hashicorp/packer/issues/2933)
- [Use single quotes or escape ';' in `boot_command`](https://askubuntu.com/a/1329415), otherwise autoinstall will silently fail
- If running from WSL, make sure that:
  - you've chosen a specific port or range of ports for Packer
  - that port or range is [proxied to WSL](https://stackoverflow.com/questions/61002681/connecting-to-wsl2-server-via-local-network)
  - and, that port or range is opened in Windows Firewall
  - in my case, sometimes I need to rerun `netsh interface portproxy add v4tov4 listenport=8100 listenaddress=0.0.0.0 connectport=8100 connectaddress=172.25.47.65` to get cloud-init to cooperate
- if I want to provision a VM templates on each node of the cluster, I need to make sure that there's a template on each node. Can't just slap one copy on the main node and have all the other ones use that.
  - and if I build with a dynamic source block, each parallel build will try to open its own webserver for cloud-init! Gotta give 'em all their own ports, even if all builds point to `8100`
