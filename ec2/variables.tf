variable "public_subnet_id" {
  description = "The ID of the public subnet."
  type        = string
}

variable "docker_sg_id" {
  description = "The ID of the Docker security group."
  type        = string
}

variable "ssh_sg_id" {
  description = "The ID of the SSH security group."
  type        = string
}

variable "http_sg_id" {
  description = "The ID of the HTTP security group."
  type        = string
}

variable "ecr_repo_url" {
  description = "The URL of the ECR repository."
  type        = string
}

variable "ec2_instance_role_name" {
  description = "The name of the EC2 instance role."
  type        = string
}

variable "cert_arn" {
  description = "The ARN of the certificate."
  type        = string
}
