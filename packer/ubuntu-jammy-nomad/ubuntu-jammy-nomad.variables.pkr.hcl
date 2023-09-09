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
