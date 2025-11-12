terraform {
  backend "s3" {
    bucket         = "mcheswick-tfstate"
    key            = "clickhouse-demo/20-eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mcheswick-tflock"
    encrypt        = true
  }
}