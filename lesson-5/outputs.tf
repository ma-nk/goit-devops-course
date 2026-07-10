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

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "URL of the ECR repository"
}
