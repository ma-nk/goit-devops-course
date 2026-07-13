variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "environment" {
  type        = string
  description = "Environment name"
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
