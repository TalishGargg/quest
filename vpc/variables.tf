variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet."
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet."
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  default     = "10.0.3.0/24"
}

variable "az1" {
  description = "Availability Zone for the first public subnet."
  default     = "us-east-1a"
}

variable "az2" {
  description = "Availability Zone for the second public subnet."
  default     = "us-east-1b"
}
