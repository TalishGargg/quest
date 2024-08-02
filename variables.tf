variable "aws_region" {
  description = "The AWS region to deploy resources."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "The CIDR block for the first public subnet."
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "The CIDR block for the second public subnet."
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet."
  default     = "10.0.2.0/24"
}

variable "az1" {
  description = "The first availability zone."
  default     = "us-east-1a"
}

variable "az2" {
  description = "The second availability zone."
  default     = "us-east-1b"
}

variable "docker_port" {
  description = "Port for Docker access"
  default     = 2375
}

variable "http_port" {
  description = "Port for HTTP access"
  default     = 80
}

variable "https_port" {
  description = "Port for HTTPS access"
  default     = 443
}

variable "ssh_port" {
  description = "Port for SSH access"
  default     = 22
}

variable "allowed_ssh_ip" {
  description = "Allowed IP for SSH access"
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  default     = "ami-12345678"
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance."
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance."
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate to use for the Load Balancer."
}


variable "vpc_id" {
  description = "The ID of the VPC to use"
  type        = string
}
