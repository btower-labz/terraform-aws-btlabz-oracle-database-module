output "rds_instance_arn" {
  description = "Amazon Resource Name (ARN) of the Instance"
  value       = aws_db_instance.main.arn
}

output "rds_instance_id" {
  description = "The RDS Instance Identifier"
  value       = aws_db_instance.main.id
}

output "rds_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = aws_db_instance.main.hosted_zone_id
}

output "rds_endpoint" {
  description = "The DNS address of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "rds_port" {
  description = "The database port"
  value       = aws_db_instance.main.port
}

output "rds_database_name" {
  description = "The database name"
  value       = aws_db_instance.main.name
}
