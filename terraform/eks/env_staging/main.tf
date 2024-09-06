# Data from remote state file
/*data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket                  = var.s3_bucket
    region                  = var.region
    encrypt                 = var.s3_encryption
    shared_credentials_file = var.shared_credentials_file
    profile                 = var.profile
    dynamodb_table          = var.dynamodb_table
    key                     = var.s3_bucket_key
  }
}*/

# create VPC
module "network" {
  source = "../../modules/vpc"

  cluster_name            = var.cluster_name
  name_prefix             = var.name_prefix
  main_network_block      = var.main_network_block
  subnet_prefix_extension = var.subnet_prefix_extension
  zone_offset             = var.zone_offset
}

# Create EKS cluster
module "eks-cluster" {
  source = "../../modules/eks_module/"

  vpc_id                          = module.network.vpc_id
  private_subnets                 = module.network.private_subnet
  aws_security_group_pub_alb      = module.network.alb_security_group_id
  cluster_name                    = var.cluster_name
  eks_managed_node_groups         = var.eks_managed_node_groups
  autoscaling_average_cpu         = var.autoscaling_average_cpu
}

# Configure EKS cluster
module "config" {
  source = "../../modules/config/"
  eks_cluster_endpoint                    = module.eks-cluster.eks_cluster_endpoint
  oidc_provider_arn                       = module.eks-cluster.oidc_provider_arn
  cluster_name                            = var.cluster_name
  cluster_certificate_authority_data      = module.eks-cluster.cluster_certificate_authority_data
  #spot_termination_handler_chart_name      = var.spot_termination_handler_chart_name
  #spot_termination_handler_chart_repo      = var.spot_termination_handler_chart_repo
  #spot_termination_handler_chart_version   = var.spot_termination_handler_chart_version
  #spot_termination_handler_chart_namespace = var.spot_termination_handler_chart_namespace
  #dns_base_domain                          = var.dns_base_domain
  #ingress_gateway_name                     = var.ingress_gateway_name
  #ingress_gateway_iam_role                 = var.ingress_gateway_iam_role
  #ingress_gateway_chart_name               = var.ingress_gateway_chart_name
  #ingress_gateway_chart_repo               = var.ingress_gateway_chart_repo
  #ingress_gateway_chart_version            = var.ingress_gateway_chart_version
  #external_dns_iam_role                    = var.external_dns_iam_role
  #external_dns_chart_name                  = var.external_dns_chart_name
  #external_dns_chart_repo                  = var.external_dns_chart_repo
  #external_dns_chart_version               = var.external_dns_chart_version
  #external_dns_values                      = var.external_dns_values
  #namespaces                               = var.namespaces
  name_prefix                              = var.name_prefix
  admin_users                              = var.admin_users
  developer_users                          = var.developer_users

  /*depends_on = [
    module.network,
    module.eks-cluster
  ]*/
}