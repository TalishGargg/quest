variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate to use for HTTPS"
  default     = "arn:aws:acm:us-east-1:112774363432:certificate/174feefb-ce34-444e-a15c-74c10e5fedaf"
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created"
  default     = "vpc-08e8adcdc71c152a2"
}

variable "subnet_ids" {
  description = "A list of public subnet IDs to launch the load balancer in"
  type        = list(string)
  default     = ["subnet-0b3346acafaa050ce", "subnet-035e54239577a73e3"]
}

variable "http_sg_id" {
  description = "Security group ID for HTTP access"
  default     = "sg-0900a38208330ba13"
}

