provider "aws" {
  region = var.aws_region
}

resource "aws_lb" "quest_alb" {
  name               = "QuestALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.http_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "QuestALB"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.quest_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.quest_http.arn
        weight = 50
      }

      target_group {
        arn    = aws_lb_target_group.ecs_quest.arn
        weight = 50
      }
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.quest_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.quest_http.arn
        weight = 50
      }

      target_group {
        arn    = aws_lb_target_group.ecs_quest.arn
        weight = 50
      }
    }
  }
}

resource "aws_lb_target_group" "quest_http" {
  name        = "quest-http"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "quest-http"
  }
}

resource "aws_lb_target_group" "ecs_quest" {
  name        = "ecs-quest"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
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
