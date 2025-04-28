variable "app_ami_id" {
    description = "AMI ID for the application server"
    type        = string
}

variable "environment" {
  description = "The environment for the application (e.g., dev, stag, prod)"
  type        = string
  default     = "stag"
}

variable "instance_type" {
  description = "The instance type for the application server"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the application server"
  type        = string
}
variable "sg_id" {
  description = "The security group ID for the application server"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instance"
  type        = string
}