variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0b9883fb710b05ac6" # Amazon Linux 2023 AMI
}

variable "instance_type" {
  description = "The instance type to use for the instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair to use"
  type        = string
  default     = "quest"
}

variable "public_subnet_id" {
  description = "The ID of the public subnet to use"
  type        = string
  default     = "subnet-0b3346acafaa050ce"
}

variable "vpc_id" {
  description = "The ID of the VPC to use"
  type        = "vpc-08e8adcdc71c152a2"
}

variable "ssh_port" {
  description = "The port for SSH access"
  type        = number
  default     = 22
}

variable "allowed_ssh_ip" {
  description = "The IP address allowed to SSH into the instance"
  type        = string
  default     = "38.15.229.171/32"
}