variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region"
}

variable "bucket_name" {
  type        = string
  default     = "goit-devops-lesson-5-state-yuriim"
  description = "Name of the S3 bucket for Terraform state"
}

variable "table_name" {
  type        = string
  default     = "terraform-locks"
  description = "Name of the DynamoDB table for state locking"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  description = "List of CIDR blocks for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
  description = "List of availability zones"
}

variable "vpc_name" {
  type        = string
  default     = "lesson-5-vpc"
  description = "Name tag for the VPC resources"
}

variable "ecr_name" {
  type        = string
  default     = "lesson-5-ecr"
  description = "Name of the ECR repository"
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "Indicates whether images are scanned after being pushed to the repository"
}

variable "enable_lifecycle_policy" {
  type        = bool
  default     = true
  description = "Enable ECR lifecycle policy"
}

variable "max_image_count" {
  type        = number
  default     = 10
  description = "Max number of images to keep in ECR"
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
  description = "Enable NAT Gateway for private subnets"
}

