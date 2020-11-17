variable "final_snapshot_identifier_prefix" {
  description = "The prefix name to use when creating a final snapshot on cluster destroy, appends a random 8 digits to name to ensure it's unique too."
  type        = string
  default     = "final"
}

variable "skip_final_snapshot" {
  description = "Should a final snapshot be created on cluster destroy"
  type        = bool
  default     = false
}

resource "random_id" "final_snapshot" {
  byte_length = 8
}

locals {
  final_snapshot_identifier = "${var.final_snapshot_identifier_prefix}-${var.name}-${random_id.final_snapshot.hex}"
}
