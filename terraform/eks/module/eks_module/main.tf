module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.13.0"
  
  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  #create_aws_auth_configmap = true
  #manage_aws_auth_configmap = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true


  cluster_addons = {
    coredns = {
      version = "v1.10.1-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      version = "v1.27.1-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      version = "v1.12.6-eksbuild.2"
      resolve_conflicts = "OVERWRITE"
    }
  }

  node_security_group_additional_rules = {
    # allow connections from ALB security group
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      source_security_group_id = var.aws_security_group_pub_alb
    }
  }

  eks_managed_node_group_defaults = {
    #enable_bootstrap_user_data = true
    disk_size = 50
    
  }
  eks_managed_node_groups = var.eks_managed_node_groups

  /*eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }

    spot = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "spot"
      }

      taints = [{
        key    = "market"
        value  = "spot"
        effect = "NO_SCHEDULE"
      }]

      instance_types = ["t3.micro"]
      capacity_type  = "SPOT"
    }
  }*/

  tags = {
    Environment = "staging"
  }
}

# create IAM role for AWS Load Balancer Controller, and attach to EKS OIDC
module "eks_ingress_iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.17.0"

  role_name                              = "load-balancer-controller"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

# create IAM role for External DNS, and attach to EKS OIDC
module "eks_external_dns_iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.17.0"

  role_name                     = "external-dns"
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/*"]

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:external-dns"]
    }
  }
}

# set spot fleet Autoscaling policy
resource "aws_autoscaling_policy" "eks_autoscaling_policy" {
  count                  = length(var.eks_managed_node_groups)

  name                   = "${module.eks.eks_managed_node_groups_autoscaling_group_names[count.index]}-autoscaling-policy"
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[count.index]
  #autoscaling_group_name = var.eks_managed_node_groups[count.index]
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.autoscaling_average_cpu
  }
}

output "cluster_ca_cert" {
  value = module.eks.cluster_certificate_authority_data
}