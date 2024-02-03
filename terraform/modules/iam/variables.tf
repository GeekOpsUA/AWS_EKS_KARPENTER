variable "aws_region" {
  description = "The AWS region to deploy EKS."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket that the user needs access to."
  type        = string
}

variable "user_name" {
  description = "The name of the IAM user to create."
  type        = string
}

