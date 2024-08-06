# Quest Application Deployment on AWS using Terraform

This project demonstrates the deployment of the Quest application on AWS using Terraform to manage various AWS services including EC2, ECR, ECS, and ALB. The architecture is designed to ensure high availability, scalability, and efficient deployment of Docker containers.

## Architecture Overview

The architecture consists of the following components:
- **VPC (Virtual Private Cloud)**: Provides an isolated network environment for your resources. Includes two public subnets for high availability.
- **EC2 Instance**: Used as a developer machine to build and push Docker images to ECR.
- **ECR (Elastic Container Registry)**: Stores Docker images.
- **ECS (Elastic Container Service)**: Manages the deployment of Docker containers using Fargate.
- **Fargate**: A serverless compute engine for containers that works with ECS to run containers without managing servers.
- **ALB (Application Load Balancer)**: Distributes incoming traffic to the ECS tasks running in multiple availability zones.

![AWS Architecture](./quest-app.jpg)

## Detailed Flow

1. **Creating the VPC**:
    - A VPC is created along with two public subnets to ensure high availability.
    - The VPC configuration includes necessary route tables and internet gateways to allow external access.

2. **Development Environment**:
    - A developer works on the Quest application on a local machine.
    - Once changes are made, the developer connects to the EC2 instance running in the VPC using SSH.

3. **Building the Docker Image**:
    - On the EC2 instance, the developer clones the Quest application repository.
    - A Dockerfile is created and used to build the Docker image.
    - The Docker image is tagged and pushed to the ECR repository.

4. **ECR (Elastic Container Registry)**:
    - The ECR stores the Docker images, making them available for deployment.

5. **ECS (Elastic Container Service) and Fargate**:
    - ECS is configured to use Fargate for serverless container management.
    - ECS pulls the Docker image from ECR and deploys it as tasks in Fargate.
    - The tasks are distributed across multiple availability zones for high availability.

6. **ALB (Application Load Balancer)**:
    - The ALB is configured with target groups pointing to the ECS tasks.
    - It distributes incoming user requests to the ECS tasks, ensuring load balancing and fault tolerance.

7. **User Requests**:
    - Users access the Quest application via a DNS name associated with the ALB.
    - The ALB routes the requests to the appropriate ECS tasks running in different availability zones.

## Enterprise Network Improvements

To enhance the solution for an enterprise network, consider the following improvements tailored to your specific architecture:

### Storage

- **S3 (Simple Storage Service)**: 
  - Use S3 to store static assets such as images, videos, and backups. S3 offers high durability, availability, and scalability.
  - Implement S3 Lifecycle policies to manage data lifecycle and optimize storage costs by transitioning older data to less expensive storage classes like S3 Glacier.

- **RDS (Relational Database Service)**:
  - Utilize RDS for managed relational databases that the application can use to store structured data. RDS supports multiple database engines like MySQL, PostgreSQL, and SQL Server.
  - Enable Multi-AZ deployments for high availability and automated backups for data durability. Place RDS instances in private subnets to enhance security.

### Private Subnet

- Create private subnets within your VPC to host backend resources, such as RDS databases and internal services, that do not require direct internet access.
- Use NAT Gateways in public subnets to allow instances in private subnets to securely access the internet for updates and patches while keeping them inaccessible from the outside world.

### Multi-Account Strategy

- **Development VPC**: 
  - Isolate development environments in a separate AWS account with its own VPC. This ensures that development activities, such as testing new features and bug fixes, do not impact production resources.
  
- **Production VPC**:
  - Use a separate AWS account for production environments. This strategy enhances security and provides a clear separation of duties between development and production environments.
  - Implement cross-account IAM roles to enable secure access management between development and production accounts, allowing for controlled access to necessary resources.

### Route 53 and DNS

- Use **Route 53** for domain registration and DNS management. This ensures that the domains are easy for humans to understand. Route 53 offers high availability and scalability for managing DNS records.
- Configure Route 53 health checks to monitor the health of endpoints and automatically route traffic to healthy instances. This ensures that user requests are always directed to functioning services.

## Setup Instructions

### Prerequisites

- An existing AWS account with appropriate permissions.
- AWS CLI installed and configured.
- Terraform installed.
- Git installed.
- A key pair already exists in your AWS account to be used for the EC2 instance.

### Steps

1. **Clone the Repository**

    ```bash
    git clone https://github.com/TalishGargg/quest.git
    cd quest
    ```

2. **Initialize Terraform**

    ```bash
    terraform init
    ```

3. **Apply the Terraform Plan**

    ```bash
    terraform apply
    ```

    During the apply process, you will be prompted to enter the `key_name` for the EC2 instance. Provide the name of an existing key pair in your AWS account.

4. **Access the Application**

    After the deployment is complete, you can access the Quest application using the DNS name associated with the Application Load Balancer, which can be found in the AWS Management Console under the EC2 or ECS services.
