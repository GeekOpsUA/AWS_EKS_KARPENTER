variable "user_name" {
  description = "Name of the IAM user"
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
      resources = ["arn:aws:s3:::example_bucket", "arn:aws:s3:::example_bucket/*"],
      effect    = "Allow"
    },
    {
      actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"],
      resources = ["arn:aws:ecr:${var.aws_region}:*:*"],
      effect    = "Allow"
    },
    {
      actions   = ["eks:CreateCluster", "eks:DeleteCluster", "eks:DescribeCluster", "eks:ListClusters", "eks:UpdateClusterConfig", "eks:UpdateClusterVersion"],
      resources = ["*"],
      effect    = "Allow"
    },
    {
      actions   = ["eks:CreateFargateProfile", "eks:DeleteFargateProfile", "eks:DescribeFargateProfile", "eks:ListFargateProfiles"],
      resources = ["*"],
      effect    = "Allow"
    }
  ]
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
}

variable "aws_region" {
  description = "AWS region"
}
