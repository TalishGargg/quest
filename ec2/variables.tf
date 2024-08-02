variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
  default     = "ami-0ba9883b710b05ac6"
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
  default     = "my-key"
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
  default     = "subnet-0b3346acafaa050ce"  # Replace with your subnet ID
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-08e8adcdc71c152a2"  # Replace with your VPC ID
}

variable "security_groups" {
  description = "List of security group names"
  type        = list(string)
  default     = ["docker", "ssh", "http"]
}

variable "ingress_ports" {
  description = "Mapping of security group names to their ingress ports"
  type        = map(number)
  default = {
    docker = 3000
    ssh    = 22
    http   = 80
    https  = 443
  }
}
