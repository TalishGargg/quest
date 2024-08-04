variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "port" {
  description = "Port number"
  type        = number
  default     = 3000
}

variable "http_sg_id" {
  description = "The ID of the HTTP security group."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate."
  type        = string
}
