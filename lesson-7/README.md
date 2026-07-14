# Lesson 7: Helm Charts and Kubernetes Deployment on EKS

This directory contains configuration files for creating AWS EKS infrastructure using Terraform, and deploying a Django application via Helm.

## Project Structure

*   `main.tf`: Main Terraform configuration, calling VPC, ECR, EKS, and S3 Backend modules.
*   `providers.tf`: Terraform provider configuration.
*   `variables.tf`: Root variables.
*   `backend.tf`: S3 backend config.
*   `outputs.tf`: Global outputs.
*   `Dockerfile`: Django app Dockerfile (copied from lesson-4).
*   `requirements.txt`: Python package requirements.
*   `manage.py`: Django management script.
*   `myproject/`: Django application settings and source code files.
*   `nginx/`: Nginx server configuration files.
*   `modules/`:
    *   `s3-backend/`: S3 bucket & DynamoDB for state.
    *   `vpc/`: VPC, subnets, gateways, routes.
    *   `ecr/`: ECR registry & policy.
    *   `eks/`: EKS cluster, node groups, and IAM roles.
*   `charts/`:
    *   `django-app/`: Helm chart for deploying the Django application.
        *   `Chart.yaml`: Helm chart metadata.
        *   `values.yaml`: Parameters for the image, service, configuration, and autoscaling.
        *   `templates/`:
            *   `deployment.yaml`: Application Deployment.
            *   `service.yaml`: Service of type LoadBalancer.
            *   `configmap.yaml`: ConfigMap for environment variables.
            *   `secret.yaml`: Secrets.
            *   `hpa.yaml`: Horizontal Pod Autoscaler template.

## Infrastructure Configuration

Key variables in `variables.tf`:
*   `aws_region`: AWS region (default: `eu-north-1`).

Modules configured:
1.  **VPC**: Public and private subnets, NAT Gateway, Route Tables.
2.  **ECR**: ECR repository (`app-repo`) to store the Django app image.
3.  **EKS**: EKS cluster running on private subnets with managed Node Groups (`t2.micro` instances).

## Helm Chart Details

The Helm chart implements:
1.  **Deployment**: Pulls the Django app image from ECR and injects environment variables from a ConfigMap using `envFrom`.
2.  **Service**: Exposed as a `LoadBalancer` for external access.
3.  **HPA**: Automatically scales the pods from 2 to 6 replicas when CPU load exceeds 70%.
4.  **ConfigMap**: Contains database connection hosts/ports, `DEBUG`, and `ALLOWED_HOSTS` configurations (migrated from lesson-4 configuration).
5.  **Secret**: Holds sensitive database password credentials (`POSTGRES_PASSWORD`).

## Usage

### Terraform (Infrastructure)

1. Initialize Terraform:
   ```bash
   terraform init
   ```
2. Apply changes to build VPC, EKS, and ECR:
   ```bash
   terraform apply
   ```

### Helm (Deployment)

To deploy the Helm chart:
```bash
helm install django-app ./charts/django-app
```
