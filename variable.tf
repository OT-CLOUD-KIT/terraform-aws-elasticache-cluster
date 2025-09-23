variable "name" {
  description = "Name prefix for ElastiCache resources"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ElastiCache"
  type        = list(string)
  default = [ "subnet-0507f737d40c35d3a" , "subnet-0917528eb0073ff53"]
}



variable "transit_encryption_enabled" {
  description = "Enable in-transit encryption"
  type        = bool
  default     = false

}

variable "parameter_group_enabled" {
  description = "Whether to create a custom parameter group"
  type        = bool
  default     = false
}

variable "parameter_group_name" {
  description = "Name of the parameter group to use"
  type        = string
  default     = ""
}

variable "redis_family" {
  description = "Redis parameter group family"
  type        = string
  default = "redis7"
}

variable "parameter" {
  description = "List of parameter maps for custom parameter group"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
     {
    name  = "latency-tracking"
    value = "yes"
  }
  ]
}

variable "cluster_mode_enabled" {
  description = "Enable Redis cluster mode"
  type        = bool
  default     = false
}

variable "number_cache_clusters" {
  description = "Number of cache clusters for the replication group"
  type        = number
  default     = 1
}

variable "node_type" {
  description = "The instance class to be used"
  type        = string
  default = "cache.t3.medium"
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover"
  type        = bool
  default     = false
}

variable "multi_az_enabled" {
  description = "Enable Multi-AZ for Redis"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Auto minor version upgrade"
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Enable encryption at rest"
  type        = bool
  default     = false
}

variable "auth_token" {
  description = "Password used to access a password protected server"
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "KMS key ID for encryption at rest"
  type        = string
  default     = null
}

variable "redis_engine_version" {
  description = "Version of Redis engine"
  type        = string
}

variable "port" {
  description = "Port number on which Redis will accept connections"
  type        = number
  default     = 6379
}


variable "snapshot_arns" {
  description = "List of ARNs of Redis RDB snapshot files"
  type        = list(string)
  default     = []
}

variable "snapshot_name" {
  description = "Name of a snapshot from which to restore data"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "Weekly maintenance window"
  type        = string
  default     = null
}

variable "notification_topic_arn" {
  description = "ARN of the SNS topic to send notifications"
  type        = string
  default     = null
}

variable "snapshot_window" {
  description = "Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot"
  type        = string
  default     = null
}

variable "snapshot_retention_limit" {
  description = "Number of days for which ElastiCache retains automatic snapshots"
  type        = number
  default     = 0
}

variable "apply_immediately" {
  description = "Whether any modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "Name of your final cluster snapshot when this resource is deleted"
  type        = string
  default     = null
}

variable "replicas_per_node_group" {
  description = "Number of replicas per node group (shard)"
  type        = number
  default     = 1
}

variable "num_node_groups" {
  description = "Number of node groups (shards) for this Redis replication group"
  type        = number
  default     = 1
}

variable "replication_group_description" {
  description = "Description for the replication group"
  type        = string
  default     = ""
}

variable "elasticache_sg_id" {
    type = string
    default = ""
}


variable "env" {
  type = string
  default = "dev"
  
}

variable "owner" {
  type = string
  default = "opstree"
}

variable "app" {
  type = string
  default = "otcloud-kit"
  
}