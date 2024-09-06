resource "null_resource" "templates" {
  
  triggers = {
    always_run = "${timestamp()}"
  }
# default = "/var/lib/jenkins/k8s_manifests"
  provisioner "local-exec" {
    command = "if [ ! -d ${var.k8s_manifests_base_path}/${var.env}/${var.svc_name} ]; then mkdir ${var.k8s_manifests_base_path}/${var.env}/${var.svc_name}; fi"
  }
}

locals {
  curr_service = "${var.svc_name}"
}

locals {
  curr_env = "${var.env}"
}

resource "template_dir" "common" {
  source_dir      = "${path.module}/templates/common"
  destination_dir = "${var.k8s_manifests_base_path}/${var.env}/${var.svc_name}/common"
  vars = {
    svc_name        = "${var.svc_name}"
  }
}

resource "template_dir" "service_entry" {
  for_each = var.service_entry
  source_dir      = "${path.module}/templates/service-entry"
  destination_dir = "${var.k8s_manifests_base_path}/${var.env}/${var.svc_name}/service_entry/${each.value.hosts}"
  
  vars = {
    namespace          = "${var.svc_name}"
    hosts              = each.value.hosts
    name               = each.value.name
    number             = each.value.number
    protocol           = each.value.protocol
    resolution         = each.value.resolution
  }
}

resource "template_dir" "deployments" {
  source_dir      = "${path.module}/templates/deployments"
  destination_dir = "${var.k8s_manifests_base_path}/${var.env}/${var.svc_name}/deployments"
  vars = {
    svc_name        = "${var.svc_name}"
    version         = "v-${var.new_version}"
    node_env        = "${var.env}"
    service_api     = lookup(var.service_dependencies[local.curr_service], "api", "API not found")
    image_tag       = "${var.image_tag}"
    cpu_request     = lookup(var.service_dependencies[local.curr_service], "cpu_min", "API not found")
    cpu_limit       = lookup(var.service_dependencies[local.curr_service], "cpu_max", "API not found")
    memory_request  = lookup(var.service_dependencies[local.curr_service], "memory_min", "API not found")
    memory_limit    = lookup(var.service_dependencies[local.curr_service], "memory_max", "API not found")
    hpa_min_replica = lookup(var.service_dependencies[local.curr_service], "hpa_min", "API not found")
    #hpa_avg_memory  = lookup(var.service_dependencies[local.curr_service], "hpa_avg_memory", "hpa_avg_memory not found")
    
    hpa_avg_memory  = ((tonumber(trim(lookup(var.service_dependencies[local.curr_service], "memory_max", "API not found"), "Mi")) * 85) / 100)
  }
}

resource "template_dir" "virtual_service" {
  source_dir      = "${path.module}/templates/virtual-service"
  destination_dir = "${var.k8s_manifests_base_path}/${var.env}/${var.svc_name}/virtual-service"
  vars = {
    svc_name                      = "${var.svc_name}"
    service_api                   = lookup(var.service_dependencies[local.curr_service], "api", "API not found")
    service_domain                = lookup(var.service_domain[local.curr_env], "domain", "Domain not found")
    svc_version_old               = "${var.old_version}"
    svc_version_new               = "v-${var.new_version}"
    #gateway                       = "default/yelb-gateway"
    gateway                       = lookup(var.service_domain[local.curr_env], "gateway", "Gateway not found")
    traffic_rate_to_new_version   = tonumber("${var.traffic_rate}")
    traffic_rate_to_old_version   = 100 - tonumber("${var.traffic_rate}")
  }
}