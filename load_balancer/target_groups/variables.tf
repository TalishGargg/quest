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

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}
