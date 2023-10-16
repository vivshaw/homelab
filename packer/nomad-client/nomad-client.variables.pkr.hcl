variable "proxmox_api_url" {
  type        = string
  description = "The URL of the Proxmox API, including the port & protocol"
  sensitive = true
}

variable "proxmox_api_user" {
  type        = string
  description = "The username to use when authenticating with the Proxmox API"
  sensitive = true
}

variable "proxmox_api_token" {
  type = string
  description = "The token to use when authenticating with the Proxmox API"
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