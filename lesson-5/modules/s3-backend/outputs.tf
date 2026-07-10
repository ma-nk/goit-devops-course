output "bucket_name" {
  value       = aws_s3_bucket.state.id
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.locks.name
  description = "The name of the DynamoDB table"
}
