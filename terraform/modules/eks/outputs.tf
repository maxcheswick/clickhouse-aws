output "cluster_name" {
  description = "Name of the EKS cluster created by this module"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "API server endpoint for kubeconfig generation"
  value       = module.eks.cluster_endpoint
}

output "cluster_ca" {
  description = "Base64 encoded cluster certificate authority data"
  value       = module.eks.cluster_certificate_authority_data
}

output "oidc_provider_arn" {
  description = "ARN of the cluster's IAM OIDC provider (IRSA)"
  value       = module.eks.oidc_provider_arn
}

output "node_group_role_arn" {
  description = "IAM role ARN used by the default managed node group"
  value       = try(module.eks.eks_managed_node_groups["default"].iam_role_arn, null)
}
