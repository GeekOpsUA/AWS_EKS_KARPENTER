terraform {
  required_version = ">= 1.0.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.70.0"
    }
  }
}

variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

variable "user_name" {
  description = "Name of the IAM user"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "policy_statements" {
  description = "Map of policy statements for dynamic policy creation"
  type = list(object({
    actions   = list(string)
    resources = list(string)
    effect    = string
  }))
  default = [
    {
      actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"],
      resources = ["arn:aws:s3:::${var.s3_bucket_name}", "arn:aws:s3:::${var.s3_bucket_name}/*"],
      effect    = "Allow"
    },
    {
      actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"],
      resources = ["arn:aws:ecr:${var.aws_region}:*:*"],
      effect    = "Allow"
    },
    {
      actions   = ["eks:CreateCluster", "eks:DeleteCluster", "eks:DescribeCluster", "eks:ListClusters", "eks:UpdateClusterConfig", "eks:UpdateClusterVersion", "eks:CreateFargateProfile", "eks:DeleteFargateProfile", "eks:DescribeFargateProfile", "eks:ListFargateProfiles"],
      resources = ["*"],
      effect    = "Allow"
    }
  ]
}

provider "aws" {
  region = var.aws_region
}

resource "aws_iam_user" "user" {
  name = var.user_name
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_policy" "user_policy" {
  name   = "${var.user_name}-policy"
  policy = data.aws_iam_policy_document.user_policy.json
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.user_policy.arn
}

data "aws_iam_policy_document" "user_policy" {
  dynamic "statement" {
    for_each = var.policy_statements

    content {
      actions   = statement.value.actions
      resources = statement.value.resources
      effect    = statement.value.effect
    }
  }
}
