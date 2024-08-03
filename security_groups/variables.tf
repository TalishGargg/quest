variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = "vpc-08e8adcdc71c152a2"
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
  default     = "38.15.229.171/32"
}
