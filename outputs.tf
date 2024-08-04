output "alb_dns_https_url" {
  description = "The HTTPS URL of the Application Load Balancer"
  value       = "https://${module.load_balancer.load_balancer_dns_name}"
}
