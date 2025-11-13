variable "region" {
  description = "AWS region where the networking stack is deployed"
  type        = string
}

variable "name" {
  description = "Base name applied to VPC resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones used for subnet placement"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets aligned with azs"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets aligned with azs"
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to all networking resources"
  type        = map(string)
  default     = {}
}
