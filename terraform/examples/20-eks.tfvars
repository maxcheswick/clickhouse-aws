region              = "us-east-1"
cluster_name        = "clickhouse-demo"
cluster_version     = "1.32"
vpc_id              = "vpc-xxxxxxxx"
private_subnet_ids  = ["subnet-aaaa", "subnet-bbbb", "subnet-cccc"]
node_desired        = 3
node_min            = 3
node_max            = 6
node_instance_types = ["m6i.medium"]
node_capacity_type  = "ON_DEMAND"
tags = {
  Project = "clickhouse-demo"
}
