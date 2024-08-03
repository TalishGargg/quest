# Root level main.tf

# Define the required providers and their versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.9.3"
    }
  }
}

# Provider configuration
provider "aws" {
  region = var.aws_region
}

# Module for VPC
module "vpc" {
  source = "./vpc"

  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  az1                  = var.az1
  az2                  = var.az2
}

# Module for Security Groups
module "security_groups" {
  source = "./security_groups"

  aws_region     = var.aws_region
  vpc_id         = module.vpc.vpc_id
  docker_port    = var.docker_port
  http_port      = var.http_port
  https_port     = var.https_port
  ssh_port       = var.ssh_port
  allowed_ssh_ip = var.allowed_ssh_ip
}

# Module for EC2 instance
module "ec2" {
  source = "./ec2"

  aws_region         = var.aws_region
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_1_id
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_ids = [module.security_groups.docker_sg_id, module.security_groups.http_sg_id, module.security_groups.ssh_sg_id]
  iam_role           = module.iam.ec2_instance_role_name
}

# Module for Load Balancer
module "load_balancer" {
  source = "./load_balancer"

  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id = module.security_groups.http_sg_id
  certificate_arn   = var.certificate_arn
}

# Module for IAM
module "iam" {
  source = "./iam"
  aws_region = var.aws_region
}

module "ecr" {
  source = "./ecr"
  aws_region = var.aws_region
}