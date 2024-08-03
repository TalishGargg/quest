data "aws_vpc" "quest_vpc" {
  filter {
    name   = "tag:Name"
    values = ["QuestVPC"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet", "PublicSubnet2"]
  }
}

data "aws_security_group" "quest_sg" {
  filter {
    name   = "tag:Name"
    values = ["quest-sg"]
  }
}

data "aws_lb_target_group" "quest_http" {
  filter {
    name   = "tag:Name"
    values = ["ecs-quest"]
  }
}

data "aws_acm_certificate" "cert" {
  domain = "example.com" # Replace with your domain
}

data "aws_ecs_task_definition" "quest_task" {
  family = "quest-app-task"
}