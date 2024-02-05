output "user_arn" {
  value       = aws_iam_user.user.arn
  description = "The ARN of the IAM user."
}
