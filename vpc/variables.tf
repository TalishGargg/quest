variable "aws_region" {
  description = "The AWS region to deploy resources."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "The CIDR block for the first public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "The CIDR block for the second public subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "az1" {
  description = "The availability zone for the first public subnet."
  type        = string
  default     = "us-east-1a"
}

variable "az2" {
  description = "The availability zone for the second public subnet."
  type        = string
  default     = "us-east-1b"
}
