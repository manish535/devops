autoscaling_average_cpu = 60
eks_managed_node_groups = {
  "AppSPOT" = {
    
    key_name     = "devops-2430"
    #ami_type     = "AL2_x86_64"
    min_size     = 1
    max_size     = 30
    desired_size = 1
    disk_size    = 50
    instance_types = [
      "t3.xlarge",
      "t3a.large",
      "t3.large",
      "t3a.xlarge"
    ]
    capacity_type = "SPOT"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = false
    }]
  }
  "AppON_DEMAND" = {
    key_name     = "devops-2430"
    #ami_type     = "AL2_ARM_64"
    min_size     = 1
    max_size     = 30
    desired_size = 1
    disk_size    = 50
    instance_types = [
      "t3.xlarge",
      "t3a.large",
      "t3.large",
      #"t3a.xlarge"
    ]
    capacity_type = "ON_DEMAND"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = false
    }]
  }
}
