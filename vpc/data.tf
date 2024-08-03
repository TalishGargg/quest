data "aws_vpc" "quest_vpc" {
  filter {
    name   = "tag:Name"
    values = ["QuestVPC"]
  }
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet2"]
  }
}

data "aws_internet_gateway" "quest_igw" {
  filter {
    name   = "tag:Name"
    values = ["QuestIGW"]
  }
}

data "aws_route_table" "public_route" {
  filter {
    name   = "tag:Name"
    values = ["PublicRoute"]
  }
}
