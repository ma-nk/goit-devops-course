variable "aws_region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region"
}

variable "cluster_name" {
  type        = string
  default     = "eks-cluster-demo"
  description = "Name of the EKS cluster"
}

