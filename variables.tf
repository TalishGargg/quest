
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

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
  default     = "ami-0ba9883b710b05ac6"  # Replace with your default AMI ID
}

variable "cert_arn" {
  description = "The ARN of the certificate."
  type        = string
}

variable "docker_sg_id" {
  description = "The ID of the Docker security group."
  type        = string
}

variable "ec2_instance_role_name" {
  description = "The name of the EC2 instance role."
  type        = string
}

variable "ecr_repo_url" {
  description = "The URL of the ECR repository."
  type        = string
}

variable "http_sg_id" {
  description = "The ID of the HTTP security group."
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance."
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet."
  type        = string
}

variable "ssh_sg_id" {
  description = "The ID of the SSH security group."
  type        = string
}

variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "The image tag mutability setting for the repository."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Whether images are scanned on push."
  type        = bool
  default     = true
}
