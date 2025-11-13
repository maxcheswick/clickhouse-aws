output "bucket_name" {
  description = "S3 bucket storing Terraform remote state"
  value       = aws_s3_bucket.tf_state.id
}

output "dynamodb_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.tf_lock.name
}
