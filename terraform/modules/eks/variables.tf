variable "capacity_type" {
    default = "ON_DEMAND"
}
variable "instance_types" {
    type = list(string)
    default = ["t3.small"]
}
variable "eks_cluster_name" {
    default = "eks-cluster"
}
variable "node_group_name" {
    default = "node-group"
}
