output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.quest_alb.dns_name
}

output "quest_http_target_group_arn" {
  value = aws_lb_target_group.quest_http.arn
}

output "ecs_quest_target_group_arn" {
  value = aws_lb_target_group.ecs_quest.arn
}

output "quest_alb_arn" {
  value = aws_lb.quest_alb.arn
}

