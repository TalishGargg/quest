variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "port" {
  description = "Port number"
  type        = number
  default     = 3000
}
