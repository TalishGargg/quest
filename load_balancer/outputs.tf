output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.quest_alb.dns_name
}
