terraform {
  required_version = ">= 1.13.4"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}


provider "aws" { region = var.region }


data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.network_state_bucket
    key    = var.network_state_key
    region = var.network_state_region
  }
}


locals {
  vpc_id = coalesce(
    var.vpc_id,
    data.terraform_remote_state.network.outputs.vpc_id
  )

  private_subnet_ids = (
    var.private_subnet_ids != null && length(var.private_subnet_ids) > 0
    ? var.private_subnet_ids
    : data.terraform_remote_state.network.outputs.private_subnets
  )
}


module "eks" {
  source             = "../../modules/eks"
  region             = var.region
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = local.vpc_id
  private_subnet_ids = local.private_subnet_ids


  node_desired        = var.node_desired
  node_min            = var.node_min
  node_max            = var.node_max
  node_instance_types = var.node_instance_types
  node_capacity_type  = var.node_capacity_type


  tags = var.tags
}
