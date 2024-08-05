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

variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
  default     = "quest-app-repo"
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
