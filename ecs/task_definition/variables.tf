variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role for ECS task execution"
  type        = string
}
