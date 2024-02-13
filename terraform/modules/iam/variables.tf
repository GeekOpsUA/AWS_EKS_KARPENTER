variable "user_name" {
  description = "Name of the IAM user to be created"
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
      resources = ["arn:aws:s3:::example_bucket", "arn:aws:s3:::example_bucket/*"],
      effect    = "Allow"
    },
    {
      actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage"],
      resources = ["arn:aws:ecr:us-east-1:123456789012:repository/example"],
      effect    = "Allow"
    }

  ]
}
