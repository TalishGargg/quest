provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "quest_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = data.aws_key_pair.selected.key_name
  subnet_id     = data.aws_subnet.public_subnet.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    data.aws_security_group.docker_sg.id, 
    data.aws_security_group.ssh_quest_sg.id, 
    data.aws_security_group.http_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 2
    http_protocol_ipv6          = "disabled"
  }

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
              
              # Build Docker image
              sudo docker build -t quest-app .
              
              # Authenticate Docker to the ECR registry
              aws ecr get-login-password --region ${var.aws_region} | sudo docker login --username AWS --password-stdin 112774363432.dkr.ecr.${var.aws_region}.amazonaws.com
              
              # Tag and push the Docker image to ECR
              sudo docker tag quest-app:latest 112774363432.dkr.ecr.${var.aws_region}.amazonaws.com/quest-app-repo:latest
              sudo docker push 112774363432.dkr.ecr.${var.aws_region}.amazonaws.com/quest-app-repo:latest
              EOF
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_instance_role.name
}
