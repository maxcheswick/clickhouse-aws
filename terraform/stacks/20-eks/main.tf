terraform {
  required_version = ">= 1.13.4"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}


provider "aws" { region = var.region }


# Pull outputs from networking stack via data sources or pass via tfvars
# For simplicity here: pass vpc_id and private_subnet_ids via tfvars from previous apply outputs


module "eks" {
  source             = "../../modules/eks"
  region             = var.region
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids


  node_desired        = var.node_desired
  node_min            = var.node_min
  node_max            = var.node_max
  node_instance_types = var.node_instance_types
  node_capacity_type  = var.node_capacity_type


  tags = var.tags
}