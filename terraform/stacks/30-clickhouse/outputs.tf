output "clickhouse_namespace" {
  value       = module.clickhouse.namespace
  description = "Namespace hosting ClickHouse"
}

output "clickhouse_installation" {
  value       = module.clickhouse.installation_name
  description = "ClickHouseInstallation resource name"
}
