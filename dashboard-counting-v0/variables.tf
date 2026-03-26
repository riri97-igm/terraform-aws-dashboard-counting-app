
variable "prefix" {
  type        = string
  description = "Friendly name prefix used for tagging and naming AWS resources."
}

variable "region" {
  type        = string
  description = "AWS region where resources will be created."
  default     = "ap-southeast-1"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod) used for tagging and naming AWS resources."
  default     = "Production"

}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC."
  default     = "172.16.0.0/16"
}

variable "my_ip_cidr" {
  description = "CIDR block for my IP address to allow SSH access to the dashboard instance."
  type        = string
  default     = "175.156.202.188/32"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "172.16.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "172.16.2.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}