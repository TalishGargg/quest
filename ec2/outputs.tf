output "instance_id" {
  value = aws_instance.quest_instance.id
}

output "public_ip" {
  value = aws_instance.quest_instance.public_ip
}

output "private_ip" {
  value = aws_instance.quest_instance.private_ip
}
