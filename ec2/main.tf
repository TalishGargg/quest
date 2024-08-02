provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "quest_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [for sg in aws_security_group.sgs : sg.id]

  tags = {
    Name = "Quest"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
}

resource "aws_security_group" "sgs" {
  for_each = toset(var.security_groups)

  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ingress_ports[each.key]
    to_port     = var.ingress_ports[each.key]
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
    Name = each.key
  }
}
