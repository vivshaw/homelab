variable "pm_api_url" {
  type        = string
  description = "The URL of the Proxmox API, including the port & protocol"
}

variable "pm_user" {
  type        = string
  description = "The username to use when authenticating with the Proxmox API"
}

variable "pm_password" {
  type        = string
  description = "The password to use when authenticating with the Proxmox API"
  sensitive   = true
}
