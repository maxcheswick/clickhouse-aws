output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "IDs of the VPC private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "IDs of the VPC public subnets"
  value       = module.vpc.public_subnets
}
