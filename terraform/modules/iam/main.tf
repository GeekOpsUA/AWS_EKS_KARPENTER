variable "user_name" {}

variable "policy_statements" {}

provider "aws" {
  region = "eu-north-1" 
}

resource "aws_iam_user" "user" {
  name = var.user_name
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

resource "aws_iam_policy" "user_policy" {
  name   = "${var.user_name}-policy"
  policy = data.aws_iam_policy_document.user_policy.json
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.user_policy.arn
}
