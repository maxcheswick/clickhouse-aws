variable "region" {
  description = "AWS region where the VPC will be created."
  type        = string
}

variable "name" {
  description = "Base name used for tagging the VPC and related resources."
  type        = string
}

variable "cidr" {
  description = "CIDR block assigned to the VPC."
  type        = string
}

variable "azs" {
  description = "List of availability zones used for the subnets."
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for the private subnets."
  type        = list(string)
}

variable "tags" {
  description = "Map of tags to apply to all created VPC resources."
  type        = map(string)
  default     = {}
}
