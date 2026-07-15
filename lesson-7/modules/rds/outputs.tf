output "endpoint" {
  description = "Connection endpoint for the database (Aurora Cluster Endpoint or Standard RDS Instance Endpoint)"
  value       = try(aws_rds_cluster.aurora[0].endpoint, aws_db_instance.standard[0].endpoint, "")
}

output "reader_endpoint" {
  description = "Read-only endpoint for Aurora Cluster (empty for standard RDS)"
  value       = try(aws_rds_cluster.aurora[0].reader_endpoint, "")
}

output "port" {
  description = "Database port"
  value       = try(aws_rds_cluster.aurora[0].port, aws_db_instance.standard[0].port, 5432)
}

output "db_subnet_group_id" {
  description = "ID of the created DB Subnet Group"
  value       = aws_db_subnet_group.default.id
}

output "security_group_id" {
  description = "ID of the Security Group created for RDS"
  value       = aws_security_group.rds.id
}

output "parameter_group_id" {
  description = "ID of the Parameter Group created"
  value       = try(aws_rds_cluster_parameter_group.aurora[0].id, aws_db_parameter_group.standard[0].id, "")
}
