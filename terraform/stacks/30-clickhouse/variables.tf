variable "region" {
  type        = string
  description = "AWS region where the EKS cluster lives"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster to target"
}

variable "namespace" {
  type        = string
  default     = "clickhouse"
  description = "Namespace for ClickHouse"
}

variable "operator_chart_version" {
  type        = string
  default     = "0.25.0"
  description = "Helm chart version for the operator"
}

variable "operator_image_tag" {
  type        = string
  default     = "0.25.0"
  description = "Container image tag for the operator"
}

variable "clickhouse_release_name" {
  type        = string
  default     = "analytics"
  description = "Name of the ClickHouseInstallation resource"
}

variable "clickhouse_version" {
  type        = string
  default     = "23.8.11.29"
  description = "ClickHouse server image tag"
}

variable "shards" {
  type        = number
  default     = 2
}

variable "replicas" {
  type        = number
  default     = 2
}

variable "disk_size" {
  type        = string
  default     = "200Gi"
}

variable "storage_class" {
  type        = string
  default     = "gp3"
}

variable "cpu_request" {
  type        = string
  default     = "1000m"
}

variable "memory_request" {
  type        = string
  default     = "4Gi"
}

variable "cpu_limit" {
  type        = string
  default     = "2000m"
}

variable "memory_limit" {
  type        = string
  default     = "8Gi"
}

variable "tolerations" {
  type    = any
  default = null
}

variable "affinity" {
  type    = any
  default = null
}
