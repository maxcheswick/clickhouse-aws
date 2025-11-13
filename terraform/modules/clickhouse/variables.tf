variable "namespace" {
  type        = string
  description = "Namespace where ClickHouse operator and installation will run"
}

variable "operator_chart_version" {
  type        = string
  description = "Helm chart version for the Altinity ClickHouse operator"
}

variable "operator_image_tag" {
  type        = string
  default     = "0.23.7"
  description = "Container image tag for the ClickHouse operator"
}

variable "clickhouse_release_name" {
  type        = string
  description = "Name for the ClickHouseInstallation resource"
}

variable "clickhouse_version" {
  type        = string
  default     = "23.8.11.29"
  description = "ClickHouse server image tag"
}

variable "shards" {
  type        = number
  default     = 2
  description = "Number of shards"
}

variable "replicas" {
  type        = number
  default     = 2
  description = "Number of replicas per shard"
}

variable "disk_size" {
  type        = string
  default     = "200Gi"
  description = "Persistent volume size for each replica"
}

variable "storage_class" {
  type        = string
  default     = "gp3"
  description = "StorageClass to use for ClickHouse volumes"
}

variable "cpu_request" {
  type        = string
  default     = "1000m"
  description = "Requested CPU for ClickHouse pods"
}

variable "memory_request" {
  type        = string
  default     = "4Gi"
  description = "Requested memory for ClickHouse pods"
}

variable "cpu_limit" {
  type        = string
  default     = "2000m"
  description = "CPU limit for ClickHouse pods"
}

variable "memory_limit" {
  type        = string
  default     = "8Gi"
  description = "Memory limit for ClickHouse pods"
}

variable "tolerations" {
  type        = any
  default     = null
  description = "Optional tolerations to place on ClickHouse pods"
}

variable "affinity" {
  type        = any
  default     = null
  description = "Optional affinity rules for ClickHouse pods"
}
