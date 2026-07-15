variable "kubeconfig" {
  description = "Шлях до kubeconfig файлу"
  type        = string
  default     = "~/.kube/config"
}

variable "cluster_name" {
  description = "Назва Kubernetes кластера"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN for EKS"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC Provider URL for EKS"
  type        = string
}