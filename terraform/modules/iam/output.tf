output "user_arn" {
  value       = aws_iam_user.user.arn
  description = "The ARN of the IAM user."
}

output "user_access_key_id" {
  value       = aws_iam_access_key.user_key.id
  description = "The access key ID for the IAM user."
}

output "user_secret_access_key" {
  value       = aws_iam_access_key.user_key.secret
  description = "The secret access key for the IAM user. This should be treated as sensitive information."
}
