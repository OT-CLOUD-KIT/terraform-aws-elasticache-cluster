
# General Settings
name = "redis-cluster"
subnet_ids = [
  "subnet-0507f737d40c35d3a",
  "subnet-0917528eb0073ff53"
]



# Redis Settings
transit_encryption_enabled = true
at_rest_encryption_enabled = true
auth_token                 = null
kms_key_id                 = null
redis_engine_version       = "7.0"
redis_family               = "redis7"
port                       = 6379

# Cluster Mode & High Availability
cluster_mode_enabled       = true
node_type                  = "cache.t3.medium"
multi_az_enabled           = true
automatic_failover_enabled = true
auto_minor_version_upgrade = true

# Parameter Group
parameter_group_enabled = true
parameter_group_name    = ""
parameter = [
  {
    name  = "latency-tracking"
    value = "yes"
  }
]

# Snapshots and Maintenance
snapshot_arns             = []
snapshot_name             = null
snapshot_window           = "03:00-04:00"
snapshot_retention_limit  = 1
maintenance_window        = "sun:05:00-sun:09:00"
final_snapshot_identifier = null
apply_immediately         = true
notification_topic_arn    = null

# Replication Configuration
replicas_per_node_group       = 1
num_node_groups               = 2
replication_group_description = "Clustered Redis for development"

# Existing Security Group (Optional)
enable_public_web_security_group_resource = true
existing_sg_id                            = "" # If you're using a static SG instead of dynamic
vpc_id                                    = "vpc-035ad2443fdbac46e"



aws_security_group_variables = [
  {
    description = "common-desc-01"
    aws_security_group_egress = [
      {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH Connections"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"

      }
    ]
    aws_security_group_ingress = [
      {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Connection Anywhere"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
      }
    ]
  }
]

env  = "dev"
owner = "opstree"
app = "otcloud-kit"
region = "us-east-1"
