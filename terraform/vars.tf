variable "proxmox_api_url" {
  type        = string
  description = "The URL of the Proxmox API, including the port & protocol"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "The token ID to use when authenticating with the Proxmox API"
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "The token secret to use when authenticating with the Proxmox API"
  sensitive   = true
}

variable "nodes" {
  type        = list(string)
  description = "Names of the nodes in the Proxmox cluster"
  default     = ["casper", "balthasar", "melchior"]
}
