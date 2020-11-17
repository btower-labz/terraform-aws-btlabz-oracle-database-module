variable "allocated_storage" {
  description = "The amount of allocated storage (GB)."
  type        = number
  default     = 10
  validation {
    condition     = var.allocated_storage > 0
    error_message = "The port allocated_storage be a positive number."
  }
}

variable "max_allocated_storage" {
  description = "Upper limit of storage autoscaling. Set to 0 to disable storage autoscaling."
  type        = number
  default     = 0
  validation {
    condition     = var.max_allocated_storage >= 0
    error_message = "The port must be a positive number or 0."
  }
}
