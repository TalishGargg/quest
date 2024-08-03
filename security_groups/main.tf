provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "docker_sg" {
  name        = "docker"
  description = "Allow access to Docker"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = var.docker_port
    to_port     = var.docker_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker"
  }
}

resource "aws_security_group" "ssh_quest_sg" {
  name        = "ssh-quest"
  description = "Security group for SSH access"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-quest"
  }
}

resource "aws_security_group" "http_sg" {
  name        = "http"
  description = "Allow HTTP and HTTPS access"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http"
  }
}
