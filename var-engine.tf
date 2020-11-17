variable "license_model" {
  description = "License model information for this DB instance (license-included | bring-your-own-license)."
  type        = string
  default     = "license-included"
  validation {
    condition     = var.license_model == "license-included" || var.license_model == "bring-your-own-license"
    error_message = "License should be license-included or bring-your-own-license."
  }
}

#oracle-ee
#oracle-se2
#oracle-se1
#oracle-se

variable "engine" {
  description = "The database engine."
  type        = string
  default     = "oracle-se2"
}

variable "engine_version" {
  description = "The database engine version."
  type        = string
  default     = ""
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed."
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window."
  type        = bool
  default     = true
}
