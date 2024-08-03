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

  user_data = templatefile("${path.module}/user_data.tpl", {
    aws_region  = var.aws_region,
    ecr_repo_url = var.ecr_repo_url
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_instance_role.name
}
