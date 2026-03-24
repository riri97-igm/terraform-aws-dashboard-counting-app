################################################################################
# General Configuration
################################################################################

variable "region" {
  type        = string
  description = "AWS region where resources will be created"
  default     = "ap-southeast-1"
}

variable "profile" {
  type        = string
  description = "AWS CLI profile to use"
  default     = "master-programmatic-admin"
}

variable "prefix" {
  description = "Prefix for naming all resources"
  type        = string
}

################################################################################
# Networking - VPC
################################################################################

variable "vpc_name" {
  description = "Name to be used on all VPC resources"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = []
}

################################################################################
# Networking - Subnets
################################################################################

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "private_subnet_names" {
  description = "Optional names for private subnets"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Assign public IP to instances in public subnet"
  type        = bool
  default     = false
}

################################################################################
# Networking - Gateways
################################################################################

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Use single NAT Gateway"
  type        = bool
  default     = false
}

variable "create_igw" {
  description = "Create Internet Gateway for public subnets"
  type        = bool
  default     = true
}

################################################################################
# Security
################################################################################

variable "my_ip_cidr" {
  description = "Your public IP (CIDR) for SSH access"
  type        = string
  default     = ""
}

################################################################################
# Compute - EC2
################################################################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Key pair name for EC2 SSH access"
  type        = string
  default     = ""
}