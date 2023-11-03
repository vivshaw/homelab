variable "proxmox_api_url" {
  type        = string
  description = "The URL of the Proxmox API, including the port & protocol"
  default = env("PROXMOX_URL")
  sensitive = true
}

variable "proxmox_api_user" {
  type        = string
  description = "The username (*with* realm and token ID!) to use when authenticating with the Proxmox API"
  default = env("PROXMOX_USER_REALM_AND_TOKEN_ID")
  sensitive = true
}

variable "proxmox_api_token" {
  type = string
  description = "The token to use when authenticating with the Proxmox API"
  default = env("PROXMOX_TOKEN")
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