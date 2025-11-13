region              = "us-east-1"
cluster_name        = "clickhouse-demo"
cluster_version     = "1.32"
node_desired        = 3
node_min            = 3
node_max            = 6
node_instance_types = ["m6i.medium"]
node_capacity_type  = "ON_DEMAND"
tags = {
  Project = "clickhouse-demo"
}

# Optional overrides if the networking state bucket/key differ
# network_state_bucket = "mcheswick-tfstate"
# network_state_key    = "clickhouse-demo/10-networking/terraform.tfstate"
# network_state_region = "us-east-1"
