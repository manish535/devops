output "cluster_name" {
  value = module.eks.cluster_name
}
output "user_data" {
  #value = module.eks.user_data
  value = "abc"
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
/*output "count_managed_eks_node_groups" {
  #value = module.eks.eks_managed_node_groups_autoscaling_group_names
  value = var.eks_managed_node_groups
}*/