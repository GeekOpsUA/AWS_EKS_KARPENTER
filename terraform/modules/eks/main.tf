resource "aws_eks_cluster" "name" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.name.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-eu-north-1a.id,
      aws_subnet.private-eu-north-1b.id,
      aws_subnet.public-eu-north-1a.id,
      aws_subnet.public-eu-north-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}

# Nodes
resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private-eu-north-1a.id,
    aws_subnet.private-eu-north-1b.id
  ]

  capacity_type  = var.capacity_type
  instance_types = var.instance_types

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }
}
