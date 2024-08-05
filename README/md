# Quest Application Deployment on AWS

This project demonstrates the deployment of the Quest application on AWS using various AWS services including EC2, ECR, ECS, and ALB. The architecture is designed to ensure high availability, scalability, and efficient deployment of Docker containers.

## Architecture Overview

The architecture consists of the following components:
- **EC2 Instance**: Used as a developer machine to build and push Docker images to ECR.
- **ECR (Elastic Container Registry)**: Stores Docker images.
- **ECS (Elastic Container Service)**: Manages the deployment of Docker containers using Fargate.
- **ALB (Application Load Balancer)**: Distributes incoming traffic to the ECS tasks running in multiple availability zones.

![AWS Architecture](./quest-app.jpg)

## Prerequisites

Before you begin, ensure you have the following:
- AWS account with appropriate permissions
- AWS CLI installed and configured
- Terraform installed
- Git installed

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
