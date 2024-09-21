variable "aws_region" {
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}

variable "aws_vpc" {
	description = "The default VPC in aws account"
	default			= "vpc-xxxxx"
}

variable "vpc_subnet_1" {
	description = "The subnet group"
	default			=	"subnet-xxxxx"
}

variable "vpc_subnet_2" {
	description = "The subnet group"
	default			=	"subnet-xxxxx"
}