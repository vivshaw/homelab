terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  # Authentication
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret

  # TODO: get this working with TLS!
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "nomad-client-vm" {
  count = 9
  name  = "nomad-client-vm-${count.index + 1}"
  desc  = "Ubuntu Nomad Client VM"

  # What'll we clone, and where to?
  target_node = var.nodes[count.index % length(var.nodes)]
  clone       = "nomad-client"

  # Provisioning settings
  os_type = "cloud-init"

  # QEMU settings
  agent = 1

  # VM resource settings
  cores    = 4
  sockets  = 1
  cpu      = "host"
  memory   = 4096
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot    = 0
    size    = "32G"
    type    = "virtio"
    storage = "local-lvm"
  }

  # Network settings
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  # Make sure the VMs get a static IP with a reasonable pattern
  ipconfig0 = "ip=192.168.1.${130 + count.index}/24,gw=10.98.1.1"
}
