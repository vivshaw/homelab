variable "proxmox_api_url" {
  type        = string
  description = "The URL of the Proxmox API, including the port & protocol"
  default = env("TF_VAR_proxmox_api_url")
  sensitive = true
}

variable "proxmox_api_token_id" {
  type        = string
  description = "The token ID (username with realm and token) to use when authenticating with the Proxmox API"
  default = env("TF_VAR_proxmox_api_token_id")
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type = string
  description = "The token secret to use when authenticating with the Proxmox API"
  default = env("TF_VAR_proxmox_api_token_secret")
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