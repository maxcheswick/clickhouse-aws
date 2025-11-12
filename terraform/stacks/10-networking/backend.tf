terraform {
  backend "s3" {
    bucket         = "mcheswick-tfstate"
    key            = "clickhouse-demo/10-networking/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mcheswick-tflock"
    encrypt        = true
  }
}