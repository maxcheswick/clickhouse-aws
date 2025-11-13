region               = "us-east-1"
bucket_name          = "mcheswick-tfstate"
dynamodb_table_name  = "mcheswick-tflock"
force_destroy        = false
tags = {
  Project     = "clickhouse-demo"
  Environment = "shared"
}
