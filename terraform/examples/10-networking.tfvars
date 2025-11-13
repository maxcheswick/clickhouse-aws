region         = "us-east-1"
name           = "clickhouse-demo"
cidr           = "10.50.0.0/16"
azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets = ["10.50.0.0/24", "10.50.1.0/24", "10.50.2.0/24"]
private_subnets = [
  "10.50.10.0/24",
  "10.50.11.0/24",
  "10.50.12.0/24"
]
tags = {
  Project = "clickhouse-demo"
}
