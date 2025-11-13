output "namespace" {
  description = "Namespace where ClickHouse is deployed"
  value       = kubernetes_namespace.clickhouse.metadata[0].name
}

output "operator_release" {
  description = "Name of the ClickHouse operator Helm release"
  value       = helm_release.clickhouse_operator.name
}

output "installation_name" {
  description = "Name of the ClickHouseInstallation custom resource"
  value       = kubernetes_manifest.clickhouse_installation.manifest["metadata"]["name"]
}
