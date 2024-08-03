variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition."
  type        = string
}

variable "public_subnet_ids" {
  description = "The list of public subnet IDs."
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID."
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group."
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created."
  type        = string
}
