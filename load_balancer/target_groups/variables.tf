variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "port" {
  description = "Port number"
  type        = number
  default     = 3000
}
