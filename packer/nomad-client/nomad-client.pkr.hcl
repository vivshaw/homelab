packer {
  required_plugins {
    proxmox = {
      version = "1.1.3"
      source  = "github.com/hashicorp/proxmox"
    }

    ansible = {
      version = "1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "proxmox-iso" "nomad-client" {
  # API & auth settings
  # TODO - use token auth on a dedicated API user
  proxmox_url = "${var.proxmox_api_url}"
  username    = var.proxmox_api_user
  token    = var.proxmox_api_token

  # Skip TLS verification
  # TODO - get this working with TLS!
  insecure_skip_tls_verify = true

  # General settings
  vm_name              = "nomad-client"
  template_description = "Nomad client running on Ubuntu"

  # ISO settings
  iso_url          = "https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso"
  iso_checksum     = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_storage_pool = "local"
  unmount_iso      = true

  # QEMU settings
  qemu_agent = true

  # VM resource settings
  cores           = "4"
  memory          = "4096"
  scsi_controller = "virtio-scsi-pci"
  disks {
    disk_size    = "32G"
    format       = "raw"
    storage_pool = "local-lvm"
    type         = "virtio"
  }

  # Network settings
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = "false"
  }

  # `cloud-init` settings
  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  # Boot commands
  boot_command = [
    "<esc>c<wait>",
    "linux /casper/vmlinuz autoinstall ds='nocloud-net;s=http://192.168.1.5:8100/' ---",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot<enter>"
  ]
  boot_wait         = "10s"
  boot_key_interval = "1000ms"

  # Autoinstall settings
  http_directory    = "http"
  http_bind_address = "0.0.0.0"
  # Awful hack! We need each of our builds to have a unique port else the build messes up,
  # 'cept we don't _actually_ want that- we want 'em all to pull the same config from port 8100.
  # So we let the 3 builds bind to 3 ports, and two of 'em are then unused.
  http_port_min     = 8100
  http_port_max     = 8103

  # SSH settings
  ssh_username = "magi"
  ssh_private_key_file = "~/.ssh/id_magi_system"
  ssh_timeout  = "20m"
}

build {
  name    = "nomad-client"
  
  dynamic "source" {
    for_each = var.all_nodes
    labels   = ["source.proxmox-iso.nomad-client"]
    content {
      node = source.key
      vm_id   = "${9000 + source.value.index}"
    }
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #1
  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo rm -f /etc/netplan/00-installer-config.yaml",
      "sudo sync"
    ]
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #2
  provisioner "file" {
    source      = "files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  # Provisioning the VM Template for Cloud-Init Integration in Proxmox #3
  provisioner "shell" {
    inline = ["sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"]
  }
}
