# Module for VPC
module "vpc" {
  source = "./vpc"

  aws_region = var.aws_region
}

# Module for IAM
module "iam" {
  source = "./iam"
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
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  public_subnet_id   = module.vpc.public_subnet_1_id
  docker_sg_id       = module.security_groups.docker_sg_id
  ssh_sg_id          = module.security_groups.ssh_sg_id
  http_sg_id         = module.security_groups.http_sg_id
  ecr_repo_url       = module.ecr.repository_url
}

# Module for Load Balancer
module "load_balancer" {
  source = "./load_balancer"

  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [
    module.vpc.public_subnet_1_id, 
    module.vpc.public_subnet_2_id
  ]
  security_group_id = module.security_groups.http_sg_id
  certificate_arn   = var.certificate_arn
}

# Module for ECS Task Definition
module "ecs_task_definition" {
  source             = "./ecs/task_definition"
  aws_region         = var.aws_region
  repository_url     = module.ecr.repository_url
  execution_role_arn = module.iam.ecs_task_execution_role_arn
}

# Module for ECS Cluster and Service
module "ecs_cluster_and_service" {
  source              = "./ecs"
  aws_region          = var.aws_region
  task_definition_arn = module.ecs_task_definition.task_definition_arn
  public_subnet_ids   = [
    module.vpc.public_subnet_1_id, 
    module.vpc.public_subnet_2_id
  ]
  security_group_id   = module.security_groups.http_sg_id
  target_group_arn    = module.load_balancer.quest_http_target_group_arn
  certificate_arn     = var.certificate_arn
  vpc_id              = module.vpc.vpc_id
}

# Module for ECR
module "ecr" {
  source             = "./ecr"
  repository_name    = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  scan_on_push       = var.scan_on_push
}
