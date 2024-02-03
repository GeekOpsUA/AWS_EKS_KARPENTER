# IAM module for EKS

## Example usage

```terraform
module "iam" {
  source         = "../../modules/iam"
  user_name      = "tf_user"
  s3_bucket_name = "s3_name"
  aws_region     = var.aws_region
}
```

You can save your `user_name` in `variables.tf`
