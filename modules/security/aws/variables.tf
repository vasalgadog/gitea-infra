variable "environment"{
  description = "The environment for the application (e.g., dev, stag, prod)"
  type        = string
  default     = "stag"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}
