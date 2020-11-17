variable "name" {
  description = "Resource name prefix"
  type        = string
  default     = "sandbox"
}

variable "use_prefix" {
  description = "Use name as a prefix with random suffix to name objects"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = "sandbox"
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "When to perform DB backups"
  type        = string
  default     = "02:00-03:00"
}

variable "maintenance_window" {
  description = "When to perform DB maintenance"
  type        = string
  default     = "sat:05:00-sat:06:00"
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "DB snapshot to create this database from"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster tags to snapshots."
  type        = bool
  default     = true
}

variable "port" {
  description = "The database port."
  type        = number
  default     = 1521
  validation {
    condition     = var.port > 0 && var.port <= 65535
    error_message = "The port must be a positive number."
  }
}

variable "rds_create_timeout" {
  description = "Used for Creating Instances, Replicas, and restoring from Snapshots."
  type        = string
  default     = "40m"
}

variable "rds_update_timeout" {
  description = "Used for Database modifications."
  type        = string
  default     = "80m"
}

variable "rds_delete_timeout" {
  description = "Used for destroying databases. This includes the time required to take snapshots."
  type        = string
  default     = "60m"
}

# See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html
variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle and Microsoft SQL instances (collation)."
  type        = string
  default     = ""
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted."
  type        = bool
  default     = true
}

# See: https://aws.amazon.com/rds/oracle/instance-types/
# See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Oracle.html#Oracle.Concepts.InstanceClasses
variable "instance_class" {
  description = "The RDS instance class."
  type        = string
  default     = "db.t3.small"
}

variable "option_group_name" {
  description = "Name of the DB option group to associate."
  type        = string
  default     = ""
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate."
  type        = string
  default     = ""
}
