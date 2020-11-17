
resource "aws_db_instance" "main" {

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  # availability_zone = ??
  backup_retention_period = var.backup_retention_period
  backup_window           = var.preferred_backup_window
  # See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html  
  character_set_name       = var.character_set_name == "" ? null : var.character_set_name
  copy_tags_to_snapshot    = var.copy_tags_to_snapshot
  db_subnet_group_name     = data.aws_db_subnet_group.main.name
  delete_automated_backups = var.delete_automated_backups
  deletion_protection      = var.deletion_protection
  # domain
  # domain_iam_role_name
  #enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  engine                     = var.engine
  engine_version             = var.engine_version == "" ? null : var.engine_version
  auto_minor_version_upgrade = var.auto_minor_version_upgrade


  final_snapshot_identifier = local.final_snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot

  #iam_database_authentication_enabled = var.iam_database_authentication_enabled
  # identifier = var.name
  identifier_prefix = var.name
  instance_class    = var.instance_class
  #iops=var.iops
  #kms_key_id.var.kms_key_id
  license_model = var.license_model

  #maintenance_window    = var.maintenance_window

  #monitoring_interval   = var.monitoring_interval
  #monitoring_role_arn   = var.monitoring_role_arn
  #multi_az              = var.multi_az

  name = var.name
  #option_group_name = var.option_group_name
  #var.parameter_group_name = var.parameter_group_name
  password = local.password
  #performance_insights_enabled = var.performance_insights_enabled
  #performance_insights_kms_key_id
  #performance_insights_retention_period
  port                = var.port
  publicly_accessible = var.publicly_accessible
  #replicate_source_db =
  #restore_to_point_in_time {
  #  restore_time
  #  source_db_instance_identifier
  #  source_dbi_resource_id
  #  use_latest_restorable_time
  #}
  #s3_import
  #security_group_names = 

  # snapshot_identifier
  # storage_encrypted
  # storage_type

  timeouts {
    create = var.rds_create_timeout
    update = var.rds_update_timeout
    delete = var.rds_delete_timeout
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      password
    ]
  }

  tags = var.tags
  #timezone
  username               = local.username
  vpc_security_group_ids = local.security_groups

}
