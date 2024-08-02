output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  value = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  value = module.vpc.public_subnet_2_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "docker_sg_id" {
  value = module.security_groups.docker_sg_id
}

output "http_sg_id" {
  value = module.security_groups.http_sg_id
}

output "ssh_sg_id" {
  value = module.security_groups.ssh_sg_id
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "load_balancer_arn" {
  value = module.load_balancer.load_balancer_arn
}

output "http_listener_arn" {
  value = module.load_balancer.http_listener_arn
}

output "https_listener_arn" {
  value = module.load_balancer.https_listener_arn
}

output "quest_http_target_group_arn" {
  value = module.load_balancer.quest_http_target_group_arn
}

output "ecs_quest_target_group_arn" {
  value = module.load_balancer.ecs_quest_target_group_arn
}
