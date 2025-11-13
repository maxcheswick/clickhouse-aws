variable "region" {
  description = "AWS region where backend resources are created"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique name for the Terraform state bucket"
  type        = string
  default     = "mcheswick-tfstate"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table used for state locking"
  type        = string
  default     = "mcheswick-tflock"
}

variable "force_destroy" {
  description = "Allow Terraform to delete the state bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to backend resources"
  type        = map(string)
  default     = { "Name" = "remote_state" }
}
