# Module for S3 and DynamoDB backend resources
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "goit-devops-lesson-5-state-yuriim"
  table_name  = "terraform-locks"
}

# Module for VPC network infrastructure
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "lesson-5-vpc"
}

# Module for ECR Docker registry
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-5-ecr"
  scan_on_push = true
}
