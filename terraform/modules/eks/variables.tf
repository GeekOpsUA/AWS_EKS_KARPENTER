variable "capacity_type" {
    default = "ON_DEMAND"
}
variable "instance_types" {
    type = list(string)
    default = ["t3.small"]
}
