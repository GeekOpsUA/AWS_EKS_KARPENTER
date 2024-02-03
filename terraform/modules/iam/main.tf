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
  statement {
    actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}", "arn:aws:s3:::${var.s3_bucket_name}/*"]
  }

  statement {
    actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"]
    resources = ["arn:aws:ecr:${var.aws_region}:*:*"]
  }

  statement {
    actions   = ["eks:CreateCluster", "eks:DeleteCluster", "eks:DescribeCluster", "eks:ListClusters", "eks:UpdateClusterConfig", "eks:UpdateClusterVersion"]
    resources = ["*"]
  }

  statement {
    actions   = ["eks:CreateFargateProfile", "eks:DeleteFargateProfile", "eks:DescribeFargateProfile", "eks:ListFargateProfiles"]
    resources = ["*"]
  }
}
