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

source "proxmox-iso" "ubuntu-hashistack" {
  # API & auth settings
  proxmox_url = var.proxmox_api_url
  username    = var.proxmox_api_token_id
  token    = var.proxmox_api_token_secret

  # Skip TLS verification
  # TODO - get this working with TLS!
  insecure_skip_tls_verify = true

  # General settings
  vm_name              = "ubuntu-hashistack"
  template_description = "Ubuntu Server with Hashicorp Stack"
  task_timeout = "5m"

  # ISO settings
  # Switched to a local ISO, to stop wasting time and bandwidth on downloading the same ISO a zillion times!
  # iso_url          = "https://releases.ubuntu.com/jammy/ubuntu-22.04.3-live-server-amd64.iso"
  iso_url          = "../../ubuntu-22.04.3-live-server-amd64.iso"
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
  boot_wait         = "10s"
  boot_key_interval = "800ms"

  # Autoinstall settings
  http_directory    = "http"
  http_bind_address = "0.0.0.0"

  # SSH settings
  ssh_username = "magi"
  ssh_private_key_file = "~/.ssh/id_magi_system"
  ssh_timeout  = "20m"
}

build {
  name = "ubuntu-hashistack"
  
  dynamic "source" {
    for_each = var.all_nodes
    labels   = ["source.proxmox-iso.ubuntu-hashistack"]
    
    content {
      node = source.key
      vm_id   = "${9000 + source.value.index}"

      # Each build gets a unique HTTP port, so we can build either in serial or parallel
      http_port_min = "${8100 + source.value.index}"
      http_port_max = "${8100 + source.value.index}"

      boot_command = [
        "<esc>c<wait>",
        "linux /casper/vmlinuz autoinstall ds='nocloud-net;s=http://192.168.1.40:${8100 + source.value.index}/' ---",
        "<enter><wait>",
        "initrd /casper/initrd",
        "<enter><wait>",
        "boot<enter>"
      ]
    }
  }

  provisioner "ansible" {
    playbook_file    =  "../../ansible/ubuntu_hashistack.yml"
    use_proxy        = true
  }
}
