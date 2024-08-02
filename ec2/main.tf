provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "quest_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.docker_sg.id, aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]

  tags = {
    Name = "Quest"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Update the package repository
              sudo yum update -y
              
              # Install Docker
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              
              # Install Git
              sudo yum install -y git
              
              # Clone the application repository
              git clone https://github.com/rearc/quest.git /home/ec2-user/quest
              cd /home/ec2-user/quest

              # Create Dockerfile
              cat <<EOT > Dockerfile
              FROM node:10
              ENV SECRET_WORD="SOCK_PUPPET"
              COPY ./quest/ /
              RUN chmod +x /bin/*
              RUN npm install
              EXPOSE 3000
              CMD ["npm", "start"]
              EOT
              
              # Build and run Docker container
              sudo docker build -t quest-app .
              sudo docker run -d -p 3000:3000 quest-app
              EOF
}

resource "aws_security_group" "docker_sg" {
  name        = "docker_sg"
  description = "Allow access to Docker"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
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
    Name = "docker_sg"
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "ssh_sg"
  }
}

resource "aws_security_group" "http_sg" {
  name        = "http_sg"
  description = "Allow HTTP and HTTPS access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "http_sg"
  }
}

output "instance_id" {
  value = aws_instance.quest_instance.id
}

output "public_ip" {
  value = aws_instance.quest_instance.public_ip
}

output "private_ip" {
  value = aws_instance.quest_instance.private_ip
}
