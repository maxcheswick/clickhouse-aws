output "clickhouse_namespace" {
  description = "Namespace hosting ClickHouse"
  value       = module.clickhouse.namespace
}

output "clickhouse_installation" {
  description = "ClickHouseInstallation resource name"
  value       = module.clickhouse.installation_name
}
