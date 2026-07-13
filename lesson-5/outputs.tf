output "backend_s3_bucket" {
  value       = module.s3_backend.bucket_name
  description = "Name of the S3 bucket for Terraform state"
}

output "backend_dynamodb_table" {
  value       = module.s3_backend.dynamodb_table_name
  description = "Name of the DynamoDB table for state locking"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC"
}

output "public_subnets" {
  value       = module.vpc.public_subnet_ids
  description = "IDs of the public subnets"
}

output "private_subnets" {
  value       = module.vpc.private_subnet_ids
  description = "IDs of the private subnets"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC"
}

output "internet_gateway_id" {
  value       = module.vpc.internet_gateway_id
  description = "The ID of the Internet Gateway"
}

output "nat_gateway_ids" {
  value       = module.vpc.nat_gateway_ids
  description = "List of IDs of the NAT Gateways"
}

output "public_route_table_id" {
  value       = module.vpc.public_route_table_id
  description = "The ID of the public route table"
}

output "private_route_table_ids" {
  value       = module.vpc.private_route_table_ids
  description = "List of IDs of the private route tables"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "URL of the ECR repository"
}
