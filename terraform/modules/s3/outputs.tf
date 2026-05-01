output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_regional_domain" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}
