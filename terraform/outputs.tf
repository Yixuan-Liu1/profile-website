output "cloudfront_url" {
  value = "https://${module.cloudfront.domain_name}"
}

output "site_url" {
  value = "https://${var.domain_name}"
}

output "nameservers" {
  value = module.dns.nameservers
}

output "cloudfront_distribution_id" {
  value = module.cloudfront.distribution_id
}

output "bucket_name" {
  value = module.s3.bucket_id
}
