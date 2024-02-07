provider "aws" {}
module "iam" {
  source         = "../modules/iam"
  statement      = local.statement
  s3_bucket_name = var.s3_bucket_name
  aws_region     = var.aws_region
  user_name      = var.user_name
}

locals {
  statement = {
    statement1 = {
      actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
      resources = ["arn:aws:s3:::${var.s3_bucket_name}", "arn:aws:s3:::${var.s3_bucket_name}/*"]
    }

    statement2 = {
      actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"]
      resources = ["arn:aws:ecr:${var.aws_region}:*:*"]
    }

    statement3 = {
      actions   = ["eks:CreateCluster", "eks:DeleteCluster", "eks:DescribeCluster", "eks:ListClusters", "eks:UpdateClusterConfig", "eks:UpdateClusterVersion"]
      resources = ["*"]
    }

    statement4 = {
      actions   = ["eks:CreateFargateProfile", "eks:DeleteFargateProfile", "eks:DescribeFargateProfile", "eks:ListFargateProfiles"]
      resources = ["*"]
    }
  }
}