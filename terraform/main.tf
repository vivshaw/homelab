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
  # TODO: Swap to token auth!
  pm_api_url  = var.pm_api_url
  pm_user     = var.pm_user
  pm_password = var.pm_password

  # TODO: get this working with TLS!
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "ubuntu-nomad-vm" {
  count = 9
  name  = "nomad-vm-${count.index + 1}"
  desc  = "Ubuntu Server Jammy w/ Nomad"

  # What'll we clone, and where to?
  target_node = var.nodes[count.index % length(var.nodes)]
  clone       = "ubuntu-jammy-nomad"

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
  ipconfig0 = "ip=192.168.1.${130 + count.index + 1}/24,gw=10.98.1.1"

  # SSH settings
  # TODO: Swap from password auth to SSH!
  # sshkeys = <<EOF
  # ${var.ssh_key}
  # EOF
}
