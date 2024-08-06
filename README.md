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
    - The ALB is configured with the target group pointing to the ECS tasks.
    - It distributes incoming user requests to the ECS tasks, ensuring load balancing and fault tolerance.

7. **User Requests**:
    - Users access the Quest application via a DNS name associated with the ALB.
    - The ALB routes the requests to the appropriate ECS tasks running in different availability zones.

# Improvements to the Current Architecture/Solution

To enhance the solution for an enterprise network, I would consider the following improvements given I had more time:

## Storage

### S3 (Simple Storage Service)
Every app needs a reliable storage solution for files, data, and other assets. I would leverage S3 to store static assets such as images, videos, and backups. S3 offers high durability, availability, and scalability, making it an ideal choice.

## Private Subnet

Creating private subnets within the VPC would allow hosting backend resources such as RDS databases and internal services, which do not require direct internet access.

- **NAT Gateways**: To enable instances in private subnets to securely access the internet for updates and patches, I would use NAT Gateways in public subnets. This approach keeps the backend resources secure and inaccessible from the outside world.

## Multi-Account Strategy

### Development VPC
I would isolate development environments in a separate AWS account with its own VPC. This separation ensures that development activities, such as testing new features and bug fixes, do not impact production resources.

### Production VPC
Using a separate AWS account for production environments enhances security and provides a clear separation of duties between development and production environments.

- **Cross-Account IAM Roles**: To manage access securely between development and production accounts, I would implement cross-account IAM roles, allowing for controlled access to necessary resources.

#### Note: 
There can also be a staging environment in a separate AWS account. This staging environment would serve as an intermediary step between development and production, allowing for testing in an environment that closely mirrors production without affecting live resources.

## Route 53 and DNS

### Route 53
**Route 53** would be my choice for domain registration and DNS management. This service ensures that domains are easy to understand and manage. Route 53 offers high availability and scalability for DNS records.

- **Health Checks**: To maintain service reliability, I would configure Route 53 health checks to monitor endpoint health and automatically route traffic to healthy instances. This setup ensures that user requests are always directed to functioning services.


## Instructions for Setting up Terraform 

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

    After the deployment is complete, you can access the Quest application using the DNS name associated with the Application Load Balancer, which can be found after the terraform script has executed and will be outputted on the screen
