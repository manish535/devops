# create some variables
/*variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to be created in our EKS Cluster."
}*/
variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}
variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
}
variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}
variable "eks_cluster_endpoint" {
  type = string
  description = "EKS cluster endpoint"
}

# ALB ingress controller
variable "oidc_provider_arn" {
  type = string
  description = "EKS oidc_provider_arn"
}
variable "cluster_name" {
  type = string
  description = "Cluster name"
}
variable "cluster_certificate_authority_data" {
  type = string
  description = "Cluster certificate"
}