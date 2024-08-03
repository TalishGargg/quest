data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["QuestVPC"]
  }
}

data "aws_security_group" "http_sg" {
  filter {
    name   = "tag:Name"
    values = ["http"]
  }
}
