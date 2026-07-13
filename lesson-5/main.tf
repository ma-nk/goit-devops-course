module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = var.bucket_name
  table_name  = var.table_name
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  vpc_name           = var.vpc_name
  enable_nat_gateway = var.enable_nat_gateway
}


module "ecr" {
  source                  = "./modules/ecr"
  ecr_name                = var.ecr_name
  scan_on_push            = var.scan_on_push
  enable_lifecycle_policy = var.enable_lifecycle_policy
  max_image_count         = var.max_image_count
}
