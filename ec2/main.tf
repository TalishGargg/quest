provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "quest_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    var.docker_sg_id, 
    var.ssh_sg_id, 
    var.http_sg_id
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

  user_data = templatefile("${path.module}/user_data.tpl", {
    aws_region   = var.aws_region,
    ecr_repo_url = var.ecr_repo_url
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_instance_role.name
}

