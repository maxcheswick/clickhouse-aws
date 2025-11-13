terraform {
  required_version = ">= 1.13.4"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}


provider "aws" { region = var.region }


module "vpc" {
  source          = "../../modules/vpc"
  region          = var.region
  name            = var.name
  cidr            = var.cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}