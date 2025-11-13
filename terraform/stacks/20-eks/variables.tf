variable "region" {
  description = "AWS region where the EKS cluster is deployed"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name assigned to the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Desired Kubernetes control plane version"
  type        = string
  default     = "1.32"
}

variable "vpc_id" {
  description = "ID of the VPC that hosts the cluster (overrides remote state when set)"
  type        = string
  default     = null
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the EKS node groups (overrides remote state when set)"
  type        = list(string)
  default     = null
}

variable "network_state_bucket" {
  description = "S3 bucket that stores the networking stack Terraform state"
  type        = string
  default     = "mcheswick-tfstate"
}

variable "network_state_key" {
  description = "Object key for the networking stack Terraform state file"
  type        = string
  default     = "clickhouse-demo/10-networking/terraform.tfstate"
}

variable "network_state_region" {
  description = "Region where the networking stack remote state bucket resides"
  type        = string
  default     = "us-east-1"
}

variable "node_desired" {
  description = "Desired size of the managed node group"
  type        = number
  default     = 3
}

variable "node_min" {
  description = "Minimum node count for autoscaling"
  type        = number
  default     = 3
}

variable "node_max" {
  description = "Maximum node count for autoscaling"
  type        = number
  default     = 6
}

variable "node_instance_types" {
  description = "EC2 instance types used by the node group"
  type        = list(string)
  default     = ["m6i.xlarge"]
}

variable "node_capacity_type" {
  description = "Capacity type of the managed node group (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "tags" {
  description = "Tags applied to all EKS resources"
  type        = map(string)
  default     = {}
}
