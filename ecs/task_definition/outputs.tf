output "ecr_repository_url" {
  value = aws_ecr_repository.quest_app_repo.repository_url
}

output "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = aws_ecs_task_definition.quest_task.arn
}