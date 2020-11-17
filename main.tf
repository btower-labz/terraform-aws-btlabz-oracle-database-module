
resource "aws_db_instance" "main" {

  #### Naming and tags ####

  identifier        = var.use_prefix ? null : var.name
  identifier_prefix = var.use_prefix ? format("%s-", var.name) : null
  instance_class    = var.instance_class
  name              = var.database_name

  #### Engine and licensing ####

  engine         = var.engine
  engine_version = var.engine_version == "" ? null : var.engine_version
  license_model  = var.license_model

  #### Storage definition ####

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  # iops=var.iops
  # storage_encrypted
  # storage_type

  #### Configuration and maintenance ####

  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  #maintenance_window    = var.maintenance_window
  deletion_protection = var.deletion_protection
  #option_group_name = var.option_group_name
  #var.parameter_group_name = var.parameter_group_name

  #### Backup and snapshots ####

  backup_retention_period   = var.backup_retention_period
  backup_window             = var.preferred_backup_window
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  delete_automated_backups  = var.delete_automated_backups
  final_snapshot_identifier = local.final_snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot

  #### Network and security ####

  db_subnet_group_name   = data.aws_db_subnet_group.main.name
  password               = local.password
  port                   = var.port
  publicly_accessible    = var.publicly_accessible
  username               = local.username
  vpc_security_group_ids = local.security_groups
  #multi_az              = var.multi_az

  #### Logging and monitoring ####

  #monitoring_interval   = var.monitoring_interval
  #monitoring_role_arn   = var.monitoring_role_arn

  #performance_insights_enabled = var.performance_insights_enabled
  #performance_insights_kms_key_id
  #performance_insights_retention_period

  #enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  #### Other settings ####
  #timezone
  # snapshot_identifier

  # See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html
  character_set_name = var.character_set_name == "" ? null : var.character_set_name

  # availability_zone = ??

  # domain
  # domain_iam_role_name
  # iam_database_authentication_enabled = var.iam_database_authentication_enabled

  # kms_key_id.var.kms_key_id


  #replicate_source_db =
  #restore_to_point_in_time {
  #  restore_time
  #  source_db_instance_identifier
  #  source_dbi_resource_id
  #  use_latest_restorable_time
  #}
  #s3_import
  #security_group_names = 


  # Timeout and Lyfecycle

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

  # Tags handling
  tags = merge(
    map(
      "Name", var.name
    ),
    var.tags
  )

}
