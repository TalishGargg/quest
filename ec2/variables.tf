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
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "docker_sg_id" {
  description = "The ID of the Docker security group"
  type        = string
}

variable "ssh_sg_id" {
  description = "The ID of the SSH security group"
  type        = string
}

variable "http_sg_id" {
  description = "The ID of the HTTP security group"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "quest"
}

variable "ecr_repo_url" {
  description = "The URL of the ECR repository"
  type        = string
}
