provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_task_definition" "quest_task" {
  family                   = "quest-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"
  execution_role_arn       = data.aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name        = "quest-app"
      image       = "${data.aws_ecr_repository.quest_app_repo.repository_url}:latest"
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
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      systemControls = []
    }
  ])
}
