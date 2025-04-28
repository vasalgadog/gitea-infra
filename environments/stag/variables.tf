variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "stag"
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
}

variable "db_username" {
  description = "The username for the master DB user."
  type        = string
}

variable "db_password" {
  description = "The password for the master DB user."
  type        = string
}

variable "aws_private_subnets" {
  description = "List of private subnet IDs for the DB instance."
  type        = list(string)
}

variable "aws_ec2_ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default = "ami-084568db4383264d4"
}

variable "aws_instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "app_name" {
  description = "The name of the application."
  type        = string
  default     = "gitea-devops"
}