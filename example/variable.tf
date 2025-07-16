variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "ElastiCache name prefix"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for Redis"
}

variable "transit_encryption_enabled" {
  type    = bool
  default = false
}

variable "parameter_group_enabled" {
  type    = bool
  default = false
}

variable "parameter_group_name" {
  type    = string
  default = ""
}

variable "redis_family" {
  type = string
}

variable "parameter" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "cluster_mode_enabled" {
  type    = bool
  default = false
}

variable "node_type" {
  type = string
}

variable "automatic_failover_enabled" {
  type    = bool
  default = false
}

variable "multi_az_enabled" {
  type    = bool
  default = false
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = true
}

variable "at_rest_encryption_enabled" {
  type    = bool
  default = false
}

variable "auth_token" {
  type    = string
  default = null
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "redis_engine_version" {
  type = string
}

variable "port" {
  type    = number
  default = 6379
}


variable "snapshot_arns" {
  type    = list(string)
  default = []
}

variable "snapshot_name" {
  type    = string
  default = null
}

variable "maintenance_window" {
  type    = string
  default = null
}

variable "notification_topic_arn" {
  type    = string
  default = null
}

variable "snapshot_window" {
  type    = string
  default = null
}

variable "snapshot_retention_limit" {
  type    = number
  default = 0
}

variable "apply_immediately" {
  type    = bool
  default = false
}

variable "final_snapshot_identifier" {
  type    = string
  default = null
}

variable "replicas_per_node_group" {
  type    = number
  default = 1
}

variable "num_node_groups" {
  type    = number
  default = 1
}

variable "replication_group_description" {
  type    = string
  default = ""
}

variable "enable_public_web_security_group_resource" {
  type        = bool
  description = "This variable is to create Web Security Group"
  default     = true
}



variable "elasticache_sg_name" {
  type    = string
  default = "dev_sg"
}
variable "vpc_id" {
  type    = string
  default = ""
}


variable "existing_sg_id" {
  type    = string
  default = ""
}

variable "aws_security_group_variables" {
  description = "A map of all security group variables"
  type = list(object({
    description = optional(string)
    aws_security_group_ingress = optional(list(object({
      description      = optional(string)
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string))
      security_groups  = optional(list(string))
      ipv6_cidr_blocks = optional(list(string))
      prefix_list_ids  = optional(list(string))
      self             = optional(bool)
    })))
    aws_security_group_egress = optional(list(object({
      description      = optional(string)
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string))
      security_groups  = optional(list(string))
      ipv6_cidr_blocks = optional(list(string))
      prefix_list_ids  = optional(list(string))
      self             = optional(bool)
    })))
  }))
}



variable "env" {
  type        = string
  description = "Environment (d, p, q, s, g)"
  default     = "p"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of: d, p, q, s, g"
  }
}

variable "bu" {
  type        = string
  description = "Business unit (max 10 characters)"
  default     = "BP"
  validation {
    condition     = length(var.bu) <= 10
    error_message = "Business unit name must be <= 10 characters"
  }
}

variable "app" {
  type        = string
  description = "Application name (max 10 characters)"
  default     = "database"
  validation {
    condition     = length(var.app) <= 10
    error_message = "App name must be <= 10 characters"
  }
}

variable "program" {
  type        = string
  description = "Program name (e.g., ot-cloud-kit)"
  default     = "OT"
}

variable "resource" {
  type        = string
  description = "Optional resource name (max 15 characters)"
  default     = ""
  validation {
    condition     = length(var.resource) <= 15
    error_message = "Resource name must be <= 15 characters"
  }
}

variable "team" {
  type        = string
  description = "Team owner or contact (e.g., devops@example.com)"
  default     = "infra"
}

variable "region" {
  type        = string
  description = "AWS Region where resources will be deployed"
  default     = "us-east-1"
}

# Optional Random Name Generator
variable "enabled_features" {
  type        = list(string)
  description = "List of enabled features for name generation"
  default     = []
}

variable "create" {
  type        = bool
  description = "Whether to create resources (module-level toggle)"
  default     = true
}

variable "random_alphanumeric_len" {
  type        = number
  description = "Length of random alphanumeric string to append (1 to 4)"
  default     = 2
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "Length must be between 1 and 4"
  }
}

variable "special" {
  type        = bool
  description = "Include special characters in generated names"
  default     = false
}

variable "upper" {
  type        = bool
  description = "Include uppercase characters in generated names"
  default     = false
}

variable "number" {
  type        = bool
  description = "Include numbers in generated names"
  default     = true
}

variable "gen_no_of_names" {
  type        = number
  description = "How many names to generate using random naming logic"
  default     = 1
}