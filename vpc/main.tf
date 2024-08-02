provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "quest_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "QuestVPC"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.quest_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.quest_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.quest_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_internet_gateway" "quest_igw" {
  vpc_id = aws_vpc.quest_vpc.id
  tags = {
    Name = "QuestIGW"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.quest_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.quest_igw.id
  }

  tags = {
    Name = "PublicRoute"
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.quest_vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_internet_gateway.quest_igw.id
  }

  tags = {
    Name = "PrivateRoute"
  }
}

resource "aws_route_table_association" "public_rt_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_rt_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route.id
}
