output "quest_http_target_group_arn" {
  value = aws_lb_target_group.quest_http.arn
}

output "ecs_quest_target_group_arn" {
  value = aws_lb_target_group.ecs_quest.arn
}
