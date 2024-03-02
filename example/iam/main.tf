resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = var.igw_name
    }
}

resource "aws_subnet" "private-eu-north-1a" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.0.0/19"
    availability_zone = "eu-north-1a"

    tags = {
        "Name"                            = "private-eu-north-1a"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/demo"      = "owned"
    }
}

resource "aws_subnet" "private-eu-north-1b" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.32.0/19"
    availability_zone = "eu-north-1b"

    tags = {
        "Name"                            = "private-eu-north-1b"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/demo"      = "owned"
    }
}

resource "aws_subnet" "public-eu-north-1a" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.64.0/19"
    availability_zone       = "eu-north-1a"
    map_public_ip_on_launch = true

    tags = {
        "Name"                       = "public-eu-north-1a"
        "kubernetes.io/role/elb"     = "1"
        "kubernetes.io/cluster/demo" = "owned"
    }
}

resource "aws_subnet" "public-eu-north-1b" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.96.0/19"
    availability_zone       = "eu-north-1b"
    map_public_ip_on_launch = true

    tags = {
        "Name"                       = "public-eu-north-1b"
        "kubernetes.io/role/elb"     = "1"
        "kubernetes.io/cluster/demo" = "owned"
    }
}

resource "aws_eip" "nat" {
    vpc = true

    tags = {
        Name = var.nat_name
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public-eu-north-1a.id
    tags = {
        Name = var.nat_name
    }
    depends_on = [aws_internet_gateway.igw]
}
provider "aws" {}
module "iam" {
  source         = "../modules/iam"
  statement      = local.statement
  s3_bucket_name = var.s3_bucket_name
  aws_region     = var.aws_region
  user_name      = var.user_name
}

locals {
  statement = {
    statement1 = {
      actions   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
      resources = ["arn:aws:s3:::${var.s3_bucket_name}", "arn:aws:s3:::${var.s3_bucket_name}/*"]
    }

    statement2 = {
      actions   = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability"]
      resources = ["arn:aws:ecr:${var.aws_region}:*:*"]
    }

    statement3 = {
      actions   = ["eks:CreateCluster", "eks:DeleteCluster", "eks:DescribeCluster", "eks:ListClusters", "eks:UpdateClusterConfig", "eks:UpdateClusterVersion"]
      resources = ["*"]
    }

    statement4 = {
      actions   = ["eks:CreateFargateProfile", "eks:DeleteFargateProfile", "eks:DescribeFargateProfile", "eks:ListFargateProfiles"]
      resources = ["*"]
    }
  }
}
