# create relative variables
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}
variable "eks_managed_node_groups" {
  type        = map(any)
  description = "Map of EKS managed node group definitions to create"
}
variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}
variable "private_subnets" {
  #type = map
  description = "Private subnets for EKS cluster"
}
variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "aws_security_group_pub_alb" {
  type = string
  description = "Security group attached to public ALB"
}