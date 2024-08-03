data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet"]
  }
}

data "aws_vpc" "quest_vpc" {
  filter {
    name   = "tag:Name"
    values = ["QuestVPC"]
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

data "aws_key_pair" "selected" {
  key_name = "quest"
}
