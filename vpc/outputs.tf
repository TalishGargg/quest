output "vpc_id" {
  value = aws_vpc.quest_vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.quest_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_route.id
}
