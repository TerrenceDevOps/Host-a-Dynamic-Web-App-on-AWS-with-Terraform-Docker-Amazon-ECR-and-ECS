
# Host a Dynamic Web App on AWS with Terraform, Docker, Amazon ECR, and ECS

## Prerequisites
- AWS account
- IAM user with sufficient permissions
- AWS CLI installed and configured (`aws configure`)
- Terraform installed
- Docker installed

## Step 1: Establish Secure Connection Between Terraform and AWS
1. Create an IAM user with `programmatic access`.
2. Attach necessary policies such as `AdministratorAccess` or use fine-grained custom policies.
3. Configure your AWS credentials using:
   ```bash
   aws configure
   ```
4. Provide access key and secret key during configuration.

## Step 2: Create S3 Bucket and DynamoDB Table for Remote Terraform State
1. Define an S3 bucket to store the Terraform state file.
2. Define a DynamoDB table for state locking to prevent concurrent modifications.
3. Add the backend block in `main.tf`:
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "your-tf-state-bucket"
       key            = "app/terraform.tfstate"
       region         = "us-east-1"
       dynamodb_table = "terraform-lock"
     }
   }
   ```

## Step 3: Create a 3-Tier VPC with Terraform
1. Define resources for:
   - VPC
   - Public and private subnets
   - Internet Gateway
   - Route Tables
   - NAT Gateway
2. Associate route tables with subnets accordingly.

## Step 4: Create NAT Gateway
1. Allocate an Elastic IP address.
2. Create NAT Gateway using the EIP and public subnet.
3. Update route tables for private subnets to route through NAT Gateway.

## Step 5: Create Security Groups
1. Define security groups for:
   - ALB
   - ECS tasks
   - RDS (if used)
2. Open necessary ports (e.g., 80, 443, 5432).

## Step 6: Create RDS Instance (Optional)
1. Define RDS instance resource.
2. Set engine, instance class, DB name, master username and password.
3. Place RDS in private subnet group.
4. Use DB subnet group and security group for access.

## Step 7: Request AWS SSL Certificate
1. Use `aws_acm_certificate` resource.
2. Define domain name and validation method (DNS or email).
3. For DNS validation, use Route 53 records.

## Step 8: Create Application Load Balancer
1. Create ALB in public subnets.
2. Create target group.
3. Create listener for HTTP (80) and HTTPS (443).
4. Attach SSL certificate to HTTPS listener.

## Step 9: Create S3 Bucket for Static Files (Optional)
1. Define an S3 bucket.
2. Enable static website hosting if needed.
3. Set public read access policies or use CloudFront.

## Step 10: Create IAM Role for ECS Task Execution
1. Define IAM role with ECS task execution policy.
2. Attach role to ECS task definition.

## Step 11: Dockerize Your App
1. Create a `Dockerfile` in your app root:
   ```Dockerfile
   FROM node:18
   WORKDIR /app
   COPY . .
   RUN npm install && npm run build
   EXPOSE 3000
   CMD ["npm", "start"]
   ```
2. Build and tag your image:
   ```bash
   docker build -t my-app .
   ```

## Step 12: Push Image to Amazon ECR
1. Create a new ECR repository.
2. Authenticate Docker to your ECR:
   ```bash
   aws ecr get-login-password --region us-east-1 | \
     docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.us-east-1.amazonaws.com
   ```
3. Tag and push the Docker image:
   ```bash
   docker tag my-app <ecr-repo-url>
   docker push <ecr-repo-url>
   ```

## Step 13: Create ECS Cluster and Deploy Service
1. Create ECS cluster.
2. Define task definition using ECR image and IAM role.
3. Create ECS service:
   - Choose launch type: Fargate or EC2
   - Attach to ALB
   - Assign public IP if needed

## Step 14: Output Website URL
In your `output.tf`, use the following:
```hcl
output "website_url" {
  value = join("", [var.record_name, ".", var.domain_name])
}
```
This outputs your deployed application's URL.


