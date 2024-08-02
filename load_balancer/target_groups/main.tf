provider "aws" {
  region = var.aws_region
}

resource "aws_lb_target_group" "quest_http" {
  name        = "quest-http"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "quest-http"
  }
}

resource "aws_lb_target_group" "ecs_quest" {
  name        = "ecs-quest"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "ecs-quest"
  }
}

output "quest_http_target_group_arn" {
  value = aws_lb_target_group.quest_http.arn
}

output "ecs_quest_target_group_arn" {
  value = aws_lb_target_group.ecs_quest.arn
}