# IAM-роль для EKS-кластера
resource "aws_iam_role" "eks" {
  # Ім'я IAM-ролі для кластера EKS
  name = "${var.cluster_name}-eks-cluster"

  # Політика, яка дозволяє сервісу EKS «асумувати» цю IAM-роль
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Прив'язка IAM-ролі до політики AmazonEKSClusterPolicy
resource "aws_iam_role_policy_attachment" "eks" {
  # ARN політики, що надає дозволи для EKS-кластера
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # IAM-роль, до якої прив'язується політика
  role = aws_iam_role.eks.name
}

# Створення EKS-кластера
resource "aws_eks_cluster" "eks" {
  # Назва кластера
  name = var.cluster_name

  # ARN IAM-ролі, яка потрібна для керування кластером
  role_arn = aws_iam_role.eks.arn

  # Налаштування мережі (VPC)
  vpc_config {
    endpoint_private_access = true                                                                                               # Включає приватний доступ до API-сервера
    endpoint_public_access  = true                                                                                               # Включає публічний доступ до API-сервера
    subnet_ids              = length(var.public_subnet_ids) > 0 ? concat(var.public_subnet_ids, var.subnet_ids) : var.subnet_ids # Список підмереж (public + private), де буде працювати EKS
  }

  # Налаштування доступу до EKS-кластера
  access_config {
    authentication_mode                         = "API" # Автентифікація через API
    bootstrap_cluster_creator_admin_permissions = true  # Надає адміністративні права користувачу, який створив кластер
  }

  # Залежність від IAM-політики для ролі EKS
  depends_on = [aws_iam_role_policy_attachment.eks]
}

data "aws_caller_identity" "current" {}

resource "aws_eks_access_entry" "admin_access" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = data.aws_caller_identity.current.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = aws_eks_cluster.eks.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.admin_access.principal_arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "node_access" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = aws_iam_role.nodes.arn
  type          = "EC2_LINUX"
}

resource "aws_security_group_rule" "eks_cluster_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["10.0.0.0/16"]
  description       = "Allow VPC internal traffic to EKS cluster security group"
}
