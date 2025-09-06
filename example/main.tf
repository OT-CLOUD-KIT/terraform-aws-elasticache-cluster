
module "elasticache_security_group" {
  count                        = var.enable_public_web_security_group_resource ? 1 : 0
  source                       = "git@github.com:OT-CLOUD-KIT/terraform-aws-security-groups.git?ref=v.0.0.4" # Adjust the path if needed
  tags                         = module.standard_tags.standard_tags
  name                         = var.name
  vpc_id                       = var.vpc_id
  aws_security_group_variables = var.aws_security_group_variables
}


module "elasticache" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-elasticache-cluster.git?ref=Feature" 
  name                       = var.name
  subnet_ids                 = var.subnet_ids
  transit_encryption_enabled = var.transit_encryption_enabled
  parameter_group_enabled    = var.parameter_group_enabled
  parameter_group_name       = var.parameter_group_name
  redis_family               = var.redis_family
  parameter                  = var.parameter
  cluster_mode_enabled       = var.cluster_mode_enabled
  node_type                  = var.node_type
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  auth_token                 = var.auth_token
  kms_key_id                 = var.kms_key_id
  redis_engine_version       = var.redis_engine_version
  port                       = var.port

  env = var.env
  owner = var.owner
  app = var.app
  snapshot_arns                 = var.snapshot_arns
  snapshot_name                 = var.snapshot_name
  maintenance_window            = var.maintenance_window
  notification_topic_arn        = var.notification_topic_arn
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  apply_immediately             = var.apply_immediately
  final_snapshot_identifier     = var.final_snapshot_identifier
  replicas_per_node_group       = var.replicas_per_node_group
  num_node_groups               = var.num_node_groups
  replication_group_description = var.replication_group_description

  elasticache_sg_id = (
    var.existing_sg_id != "" ? var.existing_sg_id :
    var.enable_public_web_security_group_resource ? try(module.elasticache_security_group[0].id[0], null) : null
  )


}



