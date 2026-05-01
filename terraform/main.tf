provider "aws" {
  region  = var.aws_region
  profile = "resume-deploy"
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "resume-deploy"
}


module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  cf_arn      = module.cloudfront.distribution_arn
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name

  cf_domain_name    = try(module.cloudfront.domain_name, "")
  cf_hosted_zone_id = try(module.cloudfront.hosted_zone_id, "")

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}

module "cloudfront" {
  source          = "./modules/cloudfront"
  bucket_domain   = module.s3.bucket_regional_domain
  bucket_id       = module.s3.bucket_id
  domain_name     = var.domain_name
  certificate_arn = module.dns.certificate_arn

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}

