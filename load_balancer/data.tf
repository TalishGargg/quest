data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["QuestVPC"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Name"
    values = ["PublicSubnet"]
  }
}

data "aws_security_group" "http" {
  filter {
    name   = "tag:Name"
    values = ["http_sg"]
  }
}

data "aws_acm_certificate" "selected" {
  filter {
    name   = "tag:Name"
    values = ["QuestCert"]
  }
}
