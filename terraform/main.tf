terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }

    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
}

provider "proxmox" {
  # Authentication
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  # Don't run in parallel, to stop race conditions with VM ids
  pm_parallel = 1

  # TODO: get this working with TLS!
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "nomad-client" {
  count = 9
  name  = "nomad-client-${count.index + 1}"
  desc  = "Ubuntu Nomad Client VM"

  # What'll we clone, and where to?
  target_node = var.nodes[count.index % length(var.nodes)]
  clone       = "ubuntu-hashistack"
  full_clone  = false

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
  # Make sure the VMs get a set of static IPs in a block from .130 to .138
  ipconfig0 = "ip=192.168.1.${130 + count.index}/24,gw=192.168.1.1"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "magi"
      private_key = file("~/.ssh/id_magi_system")
      host        = "192.168.1.${130 + count.index}"
    }

    inline = [
      "echo 'This is where the Nomad cluster clients will be provisioned.'",
    ]
  }
}

resource "proxmox_vm_qemu" "nomad-leader" {
  name = "nomad-leader"
  desc = "Ubuntu Nomad Cluster Leader"

  # What'll we clone, and where to?
  target_node = "casper"
  clone       = "ubuntu-hashistack"
  full_clone  = false

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
  ipconfig0 = "ip=192.168.1.140/24,gw=192.168.1.1"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "magi"
      private_key = file("~/.ssh/id_magi_system")
      host        = "192.168.1.140"
    }

    inline = [
      "echo 'This is where the Nomad cluster leader will be provisioned.'",
    ]
  }
}

resource "proxmox_vm_qemu" "vault-server" {
  name = "vault-server"
  desc = "Ubuntu Vault Server"

  # What'll we clone, and where to?
  target_node = "balthasar"
  clone       = "ubuntu-hashistack"
  full_clone  = false

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
  ipconfig0 = "ip=192.168.1.141/24,gw=192.168.1.1"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "magi"
      private_key = file("~/.ssh/id_magi_system")
      host        = "192.168.1.141"
    }

    inline = [
      "echo 'This is where the Vault server will be provisioned.'",
    ]
  }
}

resource "proxmox_vm_qemu" "consul-server" {
  name = "consul-server"
  desc = "Ubuntu Consul Server"

  # What'll we clone, and where to?
  target_node = "melchior"
  clone       = "ubuntu-hashistack"
  full_clone  = false

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
  ipconfig0 = "ip=192.168.1.142/24,gw=192.168.1.1"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "magi"
      private_key = file("~/.ssh/id_magi_system")
      host        = "192.168.1.142"
    }

    inline = [
      "echo 'This is where the Consul server will be provisioned.'",
    ]
  }
}
