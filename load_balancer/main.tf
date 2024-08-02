provider "aws" {
  region = var.aws_region
}

# Load Balancer
resource "aws_lb" "quest_alb" {
  name               = "QuestALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http_sg.id]
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "QuestALB"
  }
}

# HTTP Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.quest_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.quest_http.arn
  }
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.quest_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn  # Provide your SSL certificate ARN

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.quest_http.arn
  }
}

# Target Group for EC2
resource "aws_lb_target_group" "quest_http" {
  name        = "quest-http"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.quest_vpc.id
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

# Target Group for ECS
resource "aws_lb_target_group" "ecs_quest" {
  name        = "ecs-quest"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.quest_vpc.id
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


