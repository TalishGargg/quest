variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type to use for the instance"
  type        = string
  default     = "t2.micro"
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
