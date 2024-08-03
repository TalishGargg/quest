output "docker_sg_id" {
  description = "ID of the Docker security group"
  value       = aws_security_group.docker_sg.id
}

output "ssh_sg_id" {
  description = "ID of the SSH security group"
  value       = aws_security_group.ssh_quest_sg.id
}

output "http_sg_id" {
  description = "ID of the HTTP security group"
  value       = aws_security_group.http_sg.id
}