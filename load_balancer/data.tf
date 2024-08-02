data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    "Name" = "PublicSubnet"
  }
}

data "aws_security_group" "http" {
  id = var.http_sg_id
}
