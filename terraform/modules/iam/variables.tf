provider "aws" {}

module "iam" {
  source         = "../modules/iam"
  statement      = var.policy_statements
  s3_bucket_name = var.s3_bucket_name
  aws_region     = var.aws_region
  user_name      = var.user_name
}
