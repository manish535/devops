autoscaling_average_cpu = 60
eks_managed_node_groups = {
  "noiseAppProdSPOT" = {
    key_name     = "devops"
    #ami_type     = "AL2_x86_64"
    min_size     = 5
    max_size     = 120
    desired_size = 5
    instance_types = [
      "r6a.xlarge"
    ]
    capacity_type = "SPOT"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = false
    }]
  }
  "noiseAppProdON_DEMAND" = {
    key_name     = "devops"
    #ami_type     = "AL2_ARM_64"
    min_size     = 2
    max_size     = 60
    desired_size = 8
    instance_types = [
      "r6a.xlarge"
    ]
    capacity_type = "ON_DEMAND"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = false
    }]
  }
}
