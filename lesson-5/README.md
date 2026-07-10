# Lesson 5: Terraform Modules and S3 Backend

AWS infrastructure using Terraform modules.

## Project Structure

*   `main.tf`: Main config, calls modules.
*   `backend.tf`: S3 backend config.
*   `outputs.tf`: Global outputs.
*   `modules/`:
    *   `s3-backend/`: S3 bucket & DynamoDB for state.
    *   `vpc/`: VPC, subnets, gateways, routes.
    *   `ecr/`: ECR registry & policy.

## Modules

### s3-backend
*   S3 bucket: Versioned, encrypted, stores state.
*   DynamoDB: Table with `LockID` for state locking.

### vpc
*   VPC with CIDR.
*   3 Public subnets (IGW route) & 3 Private subnets (NAT GW route).
*   Internet Gateway & NAT Gateway.
*   Route tables and associations.

### ecr
*   ECR repository.
*   Scan on push enabled.
*   Basic repository policy.

## Usage

### Bootstrap (First Run)

1.  Rename `backend.tf` to `backend.tf.bak`.
2.  Initialize local backend:
    ```bash
    terraform init
    ```
3.  Create backend resources:
    ```bash
    terraform apply -target=module.s3_backend
    ```
4.  Restore `backend.tf` (rename back).
5.  Migrate state to S3:
    ```bash
    terraform init -migrate-state
    ```

### Commands

```bash
terraform init      # Initialize
terraform plan      # Plan changes
terraform apply     # Apply changes
terraform destroy   # Destroy resources
```
