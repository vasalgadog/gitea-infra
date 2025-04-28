variable "environment" {
  description = "The environment name (e.g., dev, stag, prod)"
  type        = string
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

variable "private_subnets" {
  description = "List of private subnet IDs for the DB instance."
  type        = list(string)
}

variable "rds_sg_id" {
  description = "The ID of the RDS security group"
  type        = string
}