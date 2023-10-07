variable "proxmox_api_url" {
  type        = string
  description = "The URL of the Proxmox API, including the port & protocol"
}

variable "proxmox_api_user" {
  type        = string
  description = "The username to use when authenticating with the Proxmox API"
}

variable "proxmox_api_password" {
  type        = string
  description = "The password to use when authenticating with the Proxmox API"
  sensitive   = true
}

variable "ssh_username" {
  type = string
  description = "The username to use for SSHing into the VMs"
  sensitive   = true
}

variable "ssh_password" {
  type = string
  description = "The password to use for SSHing into the VMs"
  sensitive   = true
}

variable "all_nodes" {
  type        = map(map(number))
  description = "A list of all nodes in the cluster"
  default     = {
    casper = {
      index = 0
    }

    balthasar = {
      index = 1
    }

    melchior = {
      index = 2
    }
  }
}