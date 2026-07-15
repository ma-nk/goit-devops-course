data "aws_eks_cluster_auth" "eks" {
  name = module.eks.eks_cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

module "s3_backend" {
  source = "./modules/s3-backend"                # Шлях до модуля
  bucket_name = "goit-devops-lesson-7-state-yuriim"  # Унікальне ім'я S3-бакета
  table_name  = "terraform-locks"                # Ім'я DynamoDB
}

module "vpc" {
  source              = "./modules/vpc"                                       # Шлях до модуля VPC
  vpc_cidr_block      = "10.0.0.0/16"                                         # CIDR-блок для VPC
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]         # Публічні підмережі
  private_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]         # Приватні підмережі
  availability_zones  = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]            # Зони доступності
  vpc_name            = "vpc"                                                 # Ім'я VPC
}

module "ecr" {
  source          = "./modules/ecr"   # Шлях до модуля
  repository_name = "app-repo"        # Назва репозиторію
  environment     = "dev"             # Середовище
}

module "eks" {
  source          = "./modules/eks"          
  cluster_name    = "eks-cluster-demo"            # Назва кластера
  subnet_ids      = module.vpc.private_subnets     # ID підмереж
  instance_type   = "t3.medium"                    # Тип інстансів
  desired_size    = 1                             # Бажана кількість нодів
  max_size        = 2                             # Максимальна кількість нодів
  min_size        = 1                             # Мінімальна кількість нодів
}

module "jenkins" {
  source            = "./modules/jenkins"
  cluster_name      = module.eks.eks_cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}

module "argo_cd" {
  source       = "./modules/argo_cd"
  namespace    = "argocd"
  chart_version = "5.46.4"
  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}

