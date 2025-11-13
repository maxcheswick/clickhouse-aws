variable "region" {
  description = "AWS region where the EKS cluster will be created."
  type        = string
}

variable "cluster_name" {
  description = "Name to assign to the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS control plane."
  type        = string
  default     = "1.32"
}

variable "vpc_id" {
  description = "Identifier of the VPC that hosts the cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS control plane and nodes."
  type        = list(string)
}

variable "node_desired" {
  description = "Desired number of nodes for the managed node group."
  type        = number
  default     = 3
}

variable "node_min" {
  description = "Minimum number of nodes for the managed node group autoscaling."
  type        = number
  default     = 3
}

variable "node_max" {
  description = "Maximum number of nodes for the managed node group autoscaling."
  type        = number
  default     = 6
}

variable "node_instance_types" {
  description = "Allowed EC2 instance types for the managed node group."
  type        = list(string)
  default     = ["m6i.medium"]
}

variable "node_capacity_type" {
  description = "Capacity type for worker nodes (for example, ON_DEMAND or SPOT)."
  type        = string
  default     = "ON_DEMAND"
}

variable "tags" {
  description = "Map of tags to apply to all created EKS resources."
  type        = map(string)
  default     = {}
}
