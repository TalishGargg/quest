variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-08e8adcdc71c152a2"
}

variable "port" {
  description = "Port number"
  type        = number
  default     = 3000
}

variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "instance_id" {
  description = "The ID of the EC2 instance to attach to the target group"
  type        = string
  default     = "i-0a93b98d8d12cd8a1"
}

variable "ecs_target_ip" {
  description = "The IP address of the ECS task to attach to the target group"
  type        = string
  default     = "10.0.3.101"
}