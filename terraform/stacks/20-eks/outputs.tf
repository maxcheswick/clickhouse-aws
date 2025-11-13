output "cluster_name" {
  description = "Name of the provisioned EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "API server endpoint for kubeconfig"
  value       = module.eks.cluster_endpoint
}

output "cluster_ca" {
  description = "Base64 encoded cluster CA data"
  value       = module.eks.cluster_ca
}

output "oidc_provider_arn" {
  description = "ARN of the cluster OIDC provider used for IRSA"
  value       = module.eks.oidc_provider_arn
}
