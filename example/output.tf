output "redis_replication_group_id" {
  description = "Redis replication group ID"
  value       = module.elasticache.replication_group_id
}

output "redis_primary_endpoint" {
  description = "Redis primary endpoint"
  value       = module.elasticache.primary_endpoint_address
}

output "redis_reader_endpoint" {
  description = "Redis reader endpoint"
  value       = module.elasticache.reader_endpoint_address
}


output "security_group_id" {
  description = "ID of the ElastiCache security group"
  value       = var.enable_public_web_security_group_resource ? module.elasticache_security_group[0].id[0] : null
}
