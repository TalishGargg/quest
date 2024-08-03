variable "vpc_id" {
  description = "vpc-08e8adcdc71c152a2"
  type        = string
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