/*
output "vpc_id" {
  value = module.network.alb_security_group_id
}

output "user_data" {
  value = module.eks-cluster.user_data
}

output "count_managed_eks_node_groups" {
  value = module.eks-cluster.count_managed_eks_node_groups
}

output "lbc_iam_policy" {
  value = module.config.lbc_iam_policy
}

output "aws_iam_openid_connect_provider_extract_from_arn" {
  value = module.config.aws_iam_openid_connect_provider_arn
}

output "aws_iam_openid_connect_provider_extract_from_arn" {
  value = module.config.aws_iam_openid_connect_provider_extract_from_arn
}
*/

output "eks_cluster_endpoint" {
  value = module.eks-cluster.eks_cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks-cluster.cluster_certificate_authority_data
}