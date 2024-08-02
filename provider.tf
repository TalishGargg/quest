terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.9.3"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}