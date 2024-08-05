provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_cluster" "quest_cluster" {
  name = "QuestCluster2"
}

resource "aws_ecs_service" "quest_service" {
  name            = "quest-ecs"
  cluster         = aws_ecs_cluster.quest_cluster.id
  task_definition = var.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.http_sg_id, var.docker_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.ecs_quest_target_group_arn
    container_name   = "quest-app"
    container_port   = 3000
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

}
