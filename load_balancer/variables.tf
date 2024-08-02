variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate to use for HTTPS"
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created"
}

variable "subnet_ids" {
  description = "A list of public subnet IDs to launch the load balancer in"
  type        = list(string)
}

variable "http_sg_id" {
  description = "Security group ID for HTTP access"
}
