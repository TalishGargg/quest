variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
  default     = "quest-app-repo"
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
