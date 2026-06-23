terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95.0, < 6.0.0"  # satisfies both EKS and VPC 5.x
    }
  }
}