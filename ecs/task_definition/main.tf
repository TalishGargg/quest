provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_task_definition" "quest_task" {
  family                   = "quest-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"
  execution_role_arn       = "arn:aws:iam::112774363432:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name        = "quest-app"
      image       = "112774363432.dkr.ecr.us-east-1.amazonaws.com/quest-app-repo:latest"
      cpu         = 0
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
          name          = "quest-app-3000-tcp"
          appProtocol   = "http"
        }
      ]
      essential       = true
      environment     = []
      environmentFiles = []
      mountPoints     = []
      volumesFrom     = []
      ulimits         = []
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/quest-app-task"
          awslogs-create-group  = "true"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
      systemControls = []
    }
  ])
}

resource "aws_ecr_repository" "quest_app_repo" {
  name                 = "quest-app-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}

variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}
