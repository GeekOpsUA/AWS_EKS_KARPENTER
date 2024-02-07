resource "aws_iam_policy" "user_policy" {
  name   = join("-", [var.user_name, "policy"])
  policy = data.aws_iam_policy_document.user_policy.json
}

data "aws_iam_policy_document" "user_policy" {
  dynamic "statement" {
    for_each = var.statement
    content {
      actions   = lookup(statement.value, "actions")
      resources = lookup(statement.value, "resources")
    }
  }
}

# locals {
#   statement = {
#     statement1 = {
#       actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
#       resources = ["arn:aws:s3:::${var.s3_bucket_name}", "arn:aws:s3:::${var.s3_bucket_name}/*"]
#     }
# 
#     statement2 = {
#       actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"]
#       resources = ["arn:aws:ecr:${var.aws_region}:*:*"]
#     }
# 
#     statement3 = {
#       actions   = ["eks:CreateCluster", "eks:DeleteCluster", "eks:DescribeCluster", "eks:ListClusters", "eks:UpdateClusterConfig", "eks:UpdateClusterVersion"]
#       resources = ["*"]
#     }
# 
#     statement4 = {
#       actions   = ["eks:CreateFargateProfile", "eks:DeleteFargateProfile", "eks:DescribeFargateProfile", "eks:ListFargateProfiles"]
#       resources = ["*"]
#     }
#   }
# }