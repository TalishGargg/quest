variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "execution_role_arn" {
  description = "The ARN of the execution role."
  type        = string
  default     = "arn:aws:iam::112774363432:role/ecsTaskExecutionRole"
}