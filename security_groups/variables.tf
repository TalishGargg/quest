variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "docker_port" {
  description = "Port for Docker container"
  type        = number
  default     = 3000
}

variable "http_port" {
  description = "HTTP port"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS port"
  type        = number
  default     = 443
}

variable "ssh_port" {
  description = "SSH port"
  type        = number
  default     = 22
}

variable "allowed_ssh_ip" {
  description = "Allowed IP for SSH"
  type        = string
  default     = "0.0.0.0/0"
}
