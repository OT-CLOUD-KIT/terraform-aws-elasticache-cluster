
# Terraform AWS ElastiCache Redis Cluster


A reusable Terraform module to provision a **highly available Redis cluster using AWS ElastiCache** with support for encryption, parameter groups, snapshots, and more.

> **Note:** This module provisions a **clustered, multi-AZ Redis setup** ideal for **staging and production workloads**.

---

## 🔧 Features

- Clustered Redis (multi-node, multi-AZ)
- Automatic failover and encryption support
- Custom Redis parameter group support
- Snapshot configuration and KMS integration
- VPC private subnet support and SG customization

---

##  Architecture



---



## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

## Usage

```hcl
module "redis_clustered" {
  source = "OT-CLOUD-KIT/terraform-aws-elasticache-cluster"

  aws_region                   = "us-east-1"
  name                         = "redis-cluster"
  subnet_ids                   = ["subnet-0917528eb0073ff53", "subnet-0507f737d40c35d3a"]
  tags                         = {
    Environment = "dev"
    Owner       = "nikita"
  }

  transit_encryption_enabled   = true
  at_rest_encryption_enabled   = true
  auto_minor_version_upgrade   = true
  automatic_failover_enabled   = true
  multi_az_enabled             = true
  cluster_mode_enabled         = true
  node_type                    = "cache.t3.medium"
  redis_engine_version         = "7.0"
  port                         = 6379
  auth_token                   = null
  kms_key_id                   = null

  parameter_group_enabled      = true
  parameter_group_name         = ""
  redis_family                 = "redis7"
  parameter = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  security_group_ids           = ["sg-04b583e203d73a91f"]

  snapshot_arns                = []
  snapshot_name                = null
  snapshot_window              = "03:00-04:00"
  snapshot_retention_limit     = 1
  maintenance_window           = "sun:05:00-sun:09:00"
  notification_topic_arn       = null
  apply_immediately            = true
  final_snapshot_identifier    = "final-snapshot"

  replicas_per_node_group      = 1
  num_node_groups              = 2

  replication_group_description = "Clustered Redis for development"
}

```


> **Note:**  
> The above example demonstrates how to use the module. All variables, resources, and outputs used here are already defined within this module.

## Resources

| Name                                                                                                                                                    | Type                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| [aws\_elasticache\_subnet\_group.elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group)     | Creates a subnet group for Redis using specified subnets                              |
| [random\_string.auth\_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)                                     | Generates an auth token if transit encryption is enabled                              |
| [aws\_elasticache\_parameter\_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group)   | Creates a custom parameter group if `parameter_group_enabled` is true                 |
| [aws\_elasticache\_replication\_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | Creates the Redis cluster with support for replicas, shards, failover, and encryption |








## Input
| Name                                                                                                                       | Description                                              | Type                | Default                                            | Required |
| -------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- | ------------------- | -------------------------------------------------- | :------: |
| <a name="input_aws_region"></a> [aws\_region](#input_aws_region)                                                           | AWS region to deploy the Redis cluster                   | `string`            | `"us-east-1"`                                      |     yes  |
| <a name="input_name"></a> [name](#input_name)                                                                              | Name prefix for all Redis resources                      | `string`            | n/a                                                |     yes   |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input_subnet_ids)                                                           | List of private subnet IDs                               | `list(string)`      | n/a                                                |     yes  |
| <a name="input_tags"></a> [tags](#input_tags)                                                                              | Tags to assign to all resources                          | `map(string)`       | `{ Environment = "dev", Owner = "nikita" }`        |     No    |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input_transit_encryption_enabled)          | Enable encryption in transit (TLS)                       | `bool`              | `true`                                             |     No   |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input_at_rest_encryption_enabled)         | Enable encryption at rest                                | `bool`              | `true`                                             |     No    |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input_auto_minor_version_upgrade)         | Allow automatic minor Redis engine upgrades              | `bool`              | `true`                                             |     No    |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input_automatic_failover_enabled)          | Enable automatic failover for HA                         | `bool`              | `true`                                             |     No   |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input_multi_az_enabled)                                        | Deploy nodes across multiple AZs                         | `bool`              | `true`                                             |     No   |
| <a name="input_cluster_mode_enabled"></a> [cluster\_mode\_enabled](#input_cluster_mode_enabled)                            | Enable Redis Cluster mode (sharding)                     | `bool`              | `true`                                             |     yes   |
| <a name="input_node_type"></a> [node\_type](#input_node_type)                                                              | Instance type for Redis nodes                            | `string`            | `"cache.t3.medium"`                                |     yes   |
| <a name="input_redis_engine_version"></a> [redis\_engine\_version](#input_redis_engine_version)                            | Redis engine version                                     | `string`            | `"7.0"`                                            |     No   |
| <a name="input_port"></a> [port](#input_port)                                                                              | Port Redis listens on                                    | `number`            | `6379`                                             |     No   |
| <a name="input_auth_token"></a> [auth\_token](#input_auth_token)                                                           | Redis AUTH token (optional if encryption enabled)        | `string`            | `null`                                             |     No   |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input_kms_key_id)                                                          | KMS key ID for encryption at rest                        | `string`            | `null`                                             |     No   |
| <a name="input_parameter_group_enabled"></a> [parameter\_group\_enabled](#input_parameter_group_enabled)                   | Whether to use a custom parameter group                  | `bool`              | `true`                                             |    No    |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input_parameter_group_name)                            | Name of the parameter group (optional if auto-generated) | `string`            | `""`                                               |     No   |
| <a name="input_redis_family"></a> [redis\_family](#input_redis_family)                                                     | Redis parameter group family (e.g. `redis7`)             | `string`            | `"redis7"`                                         |     yes   |
| <a name="input_parameter"></a> [parameter](#input_parameter)                                                               | List of custom Redis parameters                          | `list(map(string))` | `[ { name = "latency-tracking", value = "yes" } ]` |     No    |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input_security_group_ids)                                  | List of security group IDs                               | `list(string)`      | `["sg-04b583e203d73a91f"]`                         |     yes   |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input_snapshot_arns)                                                  | List of snapshot ARNs to restore from                    | `list(string)`      | `[]`                                               |     No    |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input_snapshot_name)                                                  | Name of the snapshot to restore                          | `string`            | `null`                                             |     No   |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input_maintenance_window)                                   | Preferred maintenance window                             | `string`            | `"sun:05:00-sun:09:00"`                            |     No    |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input_notification_topic_arn)                      | SNS topic ARN for maintenance events                     | `string`            | `null`                                             |     No    |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input_snapshot_window)                                            | Snapshot backup window                                   | `string`            | `"03:00-04:00"`                                    |     No   |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input_snapshot_retention_limit)                | Number of days to retain snapshots                       | `number`            | `1`                                                |     No    |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input_apply_immediately)                                      | Apply changes immediately                                | `bool`              | `true`                                             |     No   |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input_final_snapshot_identifier)             | Snapshot name to create before deletion                  | `string`            | `"final-snapshot"`                                 |     No    |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input_replicas_per_node_group)                  | Number of replicas per shard                             | `number`            | `1`                                                |     yes   |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input_num_node_groups)                                           | Number of shards (node groups)                           | `number`            | `2`                                                |     yes    |
| <a name="input_replication_group_description"></a> [replication\_group\_description](#input_replication_group_description) | Description for the Redis cluster                        | `string`            | `"Clustered Redis for development"`                |     No    |


___


## Output
| Name                                                                                                          | Description                                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| <a name="output_replication_group_id"></a> [replication\_group\_id](#output_replication_group_id)             | The ID of the ElastiCache replication group                   |
| <a name="output_primary_endpoint_address"></a> [primary\_endpoint\_address](#output_primary_endpoint_address) | The primary write endpoint of the Redis cluster               |
| <a name="output_reader_endpoint_address"></a> [reader\_endpoint\_address](#output_reader_endpoint_address)    | The read-only endpoint (reader endpoint) of the Redis cluster |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output_subnet_group_name)                      | The name of the ElastiCache subnet group used by the cluster  |



___


## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)

