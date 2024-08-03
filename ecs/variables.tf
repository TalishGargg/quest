variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition."
  type        = string
  default     = "arn:aws:ecs:us-east-1:112774363432:service/QuestCluster2/quest-task"
}

variable "public_subnet_ids" {
  description = "The list of public subnet IDs."
  type        = list(string)
  default     = ["subnet-0b3346acafaa050ce", "subnet-035e54239577a73e3"]
}

variable "security_group_id" {
  description = "The security group ID."
  type        = string
  default     = "sg-0900a38208330ba13"
}

variable "target_group_arn" {
  description = "The ARN of the target group."
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:112774363432:targetgroup/ecs-quest/1f126df1daddb1ae"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate."
  type        = string
  default     = "arn:aws:acm:us-east-1:112774363432:certificate/174feefb-ce34-444e-a15c-74c10e5fedaf"
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created."
  type        = string
  default     = "vpc-08e8adcdc71c152a2"
}
