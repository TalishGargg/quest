provider "aws" {
  region = var.aws_region
}

# Data sources for existing VPC and subnets
data "aws_vpc" "quest_vpc" {
  filter {
    name   = "tag:Name"
    values = ["QuestVPC"]
  }
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet2"]
  }
}

# Module for Security Groups
module "security_groups" {
  source = "./security_groups"

  aws_region     = var.aws_region
  vpc_id         = data.aws_vpc.quest_vpc.id
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
  vpc_id             = data.aws_vpc.quest_vpc.id
  public_subnet_id   = data.aws_subnet.public_subnet_1.id
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  security_group_ids = [
    module.security_groups.docker_sg_id, 
    module.security_groups.http_sg_id, 
    module.security_groups.ssh_sg_id
  ]
}

# Module for Load Balancer
module "load_balancer" {
  source = "./load_balancer"

  aws_region        = var.aws_region
  vpc_id            = data.aws_vpc.quest_vpc.id
  public_subnet_ids = [
    data.aws_subnet.public_subnet_1.id, 
    data.aws_subnet.public_subnet_2.id
  ]
  security_group_id = module.security_groups.http_sg_id
  certificate_arn   = var.certificate_arn
}

# Module for ECS Task Definition
module "ecs_task_definition" {
  source            = "./ecs/task_definition"
  aws_region        = var.aws_region
  repository_url    = "112774363432.dkr.ecr.us-east-1.amazonaws.com/quest-app-repo"
  execution_role_arn = "arn:aws:iam::112774363432:role/ecsTaskExecutionRole"
}

# Module for ECS Cluster and Service
module "ecs_cluster_and_service" {
  source            = "./ecs"
  aws_region        = var.aws_region
  task_definition_arn = module.ecs_task_definition.task_definition_arn
  public_subnet_ids = [
    data.aws_subnet.public_subnet_1.id, 
    data.aws_subnet.public_subnet_2.id
  ]
  security_group_id = module.security_groups.http_sg_id
  target_group_arn  = module.load_balancer.target_group_arn
  certificate_arn   = var.certificate_arn
  vpc_id            = data.aws_vpc.quest_vpc.id
}
