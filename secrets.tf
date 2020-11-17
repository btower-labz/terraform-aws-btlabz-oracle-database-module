variable "secret_path" {
  description = "Path to the secret. The secret instance will be created under the path specified."
  type        = string
  default     = ""
}

locals {
  secret_name_prefix = var.secret_path == "" ? format("%s-", var.name) : format("%s/%s-", var.secret_path, var.name)
  secret_description = format("Database secret: %s", var.name)
}

resource "aws_secretsmanager_secret" "main" {
  name_prefix             = local.secret_name_prefix
  description             = local.secret_description
  recovery_window_in_days = 0
  tags = merge(
    map(
      "Name", var.name
    ),
    var.tags
  )
}

locals {
  secret = {
    dbInstanceIdentifier = aws_db_instance.main.id
    engine               = aws_db_instance.main.engine
    host                 = aws_db_instance.main.endpoint
    port                 = aws_db_instance.main.port
    #resourceId           = aws_db_instance.main.cluster_resource_id
    username = local.username
    password = local.password
    database = aws_db_instance.main.name
  }
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(local.secret)
}

#aws_secretsmanager_secret_rotation "main" {
#  secret_id           = aws_secretsmanager_secret.main.id
#  rotation_rules {
#    automatically_after_days = 10
#  }
#}

output "rds_secret_arn" {
  description = "RDS secret ARN."
  value       = aws_secretsmanager_secret.main.arn
}

output "rds_secret_name" {
  description = "RDS secret name."
  value       = aws_secretsmanager_secret.main.name
}
