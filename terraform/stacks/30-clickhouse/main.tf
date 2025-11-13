terraform {
  required_version = ">= 1.13.4"
  required_providers {
    aws        = { source = "hashicorp/aws", version = ">= 5.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = ">= 2.31" }
    helm       = { source = "hashicorp/helm", version = ">= 2.11" }
  }
}

provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

module "clickhouse" {
  source = "../../modules/clickhouse"

  namespace               = var.namespace
  operator_chart_version  = var.operator_chart_version
  operator_image_tag      = var.operator_image_tag
  clickhouse_release_name = var.clickhouse_release_name
  clickhouse_version      = var.clickhouse_version
  shards                  = var.shards
  replicas                = var.replicas
  disk_size               = var.disk_size
  storage_class           = var.storage_class
  cpu_request             = var.cpu_request
  memory_request          = var.memory_request
  cpu_limit               = var.cpu_limit
  memory_limit            = var.memory_limit
  tolerations             = var.tolerations
  affinity                = var.affinity
}
