provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_cluster" "quest_cluster" {
  name = "QuestCluster2"
}

resource "aws_ecs_service" "quest_service" {
  name            = "quest-task"
  cluster         = aws_ecs_cluster.quest_cluster.id
  task_definition = data.aws_ecs_task_definition.quest_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.public.ids
    security_groups  = [data.aws_security_group.quest_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.quest_http.arn
    container_name   = "quest-app"
    container_port   = 3000
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
}

resource "aws_lb" "quest_alb" {
  name               = "QuestALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.quest_sg.id]
  subnets            = data.aws_subnets.public.ids

  enable_deletion_protection = false

  tags = {
    Name = "QuestALB"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.quest_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.quest_http.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.quest_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.quest_http.arn
  }
}

resource "aws_lb_target_group" "quest_http" {
  name        = "ecs-quest"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.quest_vpc.id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "ecs-quest"
  }
}
