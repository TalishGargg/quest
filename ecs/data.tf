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

data "aws_security_group" "docker_sg" {
  filter {
    name   = "tag:Name"
    values = ["docker_sg"]
  }
}

data "aws_security_group" "ssh_quest_sg" {
  filter {
    name   = "tag:Name"
    values = ["ssh-quest"]
  }
}

data "aws_security_group" "http_sg" {
  filter {
    name   = "tag:Name"
    values = ["http_sg"]
  }
}

data "aws_lb_target_group" "quest_http" {
  filter {
    name   = "tag:Name"
    values = ["ecs-quest"]
  }
}

data "aws_acm_certificate" "selected" {
  filter {
    name   = "tag:Name"
    values = ["QuestCert"]
  }
}

data "aws_ecs_task_definition" "quest_task" {
  family = "quest-app-task"
}
