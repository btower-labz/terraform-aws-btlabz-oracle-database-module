# TODO
variable "username" {
  description = "Master DB username"
  type        = string
  default     = "admin"
  validation {
    condition     = length(var.username) > 0
    error_message = "The username must be a non-empty string."
  }
}

# TODO
variable "password" {
  description = "Master DB password"
  type        = string
  default     = ""
}

resource "random_password" "main" {
  length           = 16
  upper            = true
  min_upper        = 1
  lower            = true
  min_lower        = 1
  number           = true
  min_numeric      = 1
  special          = true
  override_special = ".-!?"
  min_special      = 1
}

locals {
  username = var.username
  password = var.password == "" ? random_password.main.result : var.password
}

output "username" {
  description = "Initial RDS username."
  value       = local.username
  sensitive   = true
}

output "password" {
  description = "Initial RDS password. It must be changed."
  value       = local.password
  sensitive   = true
}
