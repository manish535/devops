variable "k8s_manifests_base_path" {
  type = string
  description = "All manifests will be generated here."
  default = "/var/lib/jenkins/k8s_manifests"
}
variable "s3_bucket" {
  type = string
  description = "Terraform state file will be stored here"
}
variable "region" {
  type = string
  description = "Operational region"
}
variable "s3_encryption" {
  type = bool
  description = "S3 encryption will be enabled or disabled"
}
variable "shared_credentials_file" {
  type = string
  description = "Credential store file for AWS"
}
variable "shared_config_files" {
  type = string
  description = "AWS config file"
}
variable "profile" {
  type = string
  description = "Profile for aws authrization"
}
variable "dynamodb_table" {
  type = string
  description = "Dynamodb table for state lock"
}
variable "s3_bucket_key" {
  type = string
  description = "State file location in s3 bucket"
}

variable "env" {
  type = string
  description = "Enviroment where to deploy workload(stage/uat/prod)"
}

variable "node_env" {
  type = string
  description = "Which environment config to choose(stage/uat/master)"
}

variable "svc_name" {
  type = string
  description = "Service name"
}

#variable "service_entry" {
#  type = map(object({
#    service_entry = string
#    namespace     = string
#    hosts         = string
#    name          = list(string)
#    number        = list(string)
#    protocol      = list(string)
#    resolution    = string
#  }))
#  default = {}
#}

variable "new_version" {
   type         = string
   description  = "new_version"
}

variable "old_version" {
   type         = string
   description  = "old_version"
}

variable "image_tag" {
   type         = string
   description  = "image_tag"
}

variable "service_entry" {
  type        = map(any)
  description = "Map of EKS managed node group definitions to create."
}

variable "traffic_rate" {
  type = string
  description = "Traffic % to route to new version"
}

variable "service_domain" {
  type = map(object({
    domain  = string
    gateway = string
  }))
  default = {
    "stage" = {
      domain  = "demo.abc.com"
      gateway = "abc"
    }
    "uat" = {
      domain  = "uat-eks.abc.com"
      gateway = "default/yelb-gateway"
    }
    "prod" = {
      domain  = "app-eks.abc.com"
      gateway = "default/noiseproductionapp-public"
    }
  }
}

variable "service_dependencies" {
  type = map(object({
    api         = string
    domain      = string
    cpu_min     = string
    cpu_max     = string
    memory_min  = string
    memory_max  = string
    hpa_min     = number
    hpa_avg_memory = string
  }))
  default = {
    service-auth = {
      api = "/auth/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-admin = {
      api = "/"
      domain = "uat-admin.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-auth-v2 = {
      api = "/auth_v2/"
      domain = "uat-eks.abc.com"
      cpu_min     = "800m"
      cpu_max     = "1200m"
      memory_min  = "1556Mi"
      memory_max  = "2048Mi"
      hpa_min     = 3
      hpa_avg_memory = "300Mi"
    }
    service-master = {
      api = "/master/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-temps = {
      api = "/temps/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-feeds = {
      api = "/feeds/"
      domain = "uat-eks.abc.com"
      cpu_min     = "2000m"
      cpu_max     = "3000m"
      memory_min  = "4000Mi"
      memory_max  = "5000Mi"
      hpa_min     = 4
      hpa_avg_memory = "300Mi"
    }
    service-friends = {
      api = "/friends/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-logging = {
      api = "/logging/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-npl = {
      api = "/npl/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-rewards = {
      api = "/rewards/"
      domain = "uat-eks.abc.com"
      cpu_min     = "2000m"
      cpu_max     = "3000m"
      memory_min  = "3072Mi"
      memory_max  = "4096Mi"
      hpa_min     = 6
      hpa_avg_memory = "300Mi"
    }
    service-step-activities = {
      api = "/step_activities/v3/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-step-recent = {
      api = "/step_activities_recent/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-streaks = {
      api = "/streaks/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-watchfaces = {
      api = "/watch_faces/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    service-challenges = {
      api = "/challenges/"
      domain = "uat-eks.abc.com"
      cpu_min     = "500m"
      cpu_max     = "800m"
      memory_min  = "1024Mi"
      memory_max  = "1536Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }
    watch-service-multisync = {
      api = "/multisync/"
      domain = "uat-eks.abc.com"
      cpu_min     = "1500m"
      cpu_max     = "2000m"
      memory_min  = "4500Mi"
      memory_max  = "5000Mi"
      hpa_min     = 2
      hpa_avg_memory = "350Mi"
    }
    watch-service-steps = {
      api = "/step-activity/"
      domain = "uat-eks.abc.com"
      cpu_min     = "1000m"
      cpu_max     = "1500m"
      memory_min  = "1524Mi"
      memory_max  = "3072Mi"
      hpa_min     = 3
      hpa_avg_memory = "300Mi"
    }
    noise-core-service = {
      api = "/core/"
      domain = "uat-eks.abc.com"
      cpu_min     = "2500m"
      cpu_max     = "3000m"
      memory_min  = "3324Mi"
      memory_max  = "4500Mi"
      hpa_min     = 4
      hpa_avg_memory = "300Mi"
    }
    user-detail-service = {
      api = "/user_detail/"
      domain = "uat-eks.abc.com"
      cpu_min     = "2500m"
      cpu_max     = "3000m"
      memory_min  = "4096Mi"
      memory_max  = "5096Mi"
      hpa_min     = 4
      hpa_avg_memory = "900Mi"
    }
    watch-service-stress = {
      api = "/watch/stress/v1/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    watch-service-blood-oxygen = {
      api = "/watch/blood_oxygen/v1/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    watch-service-heartrates = {
      api = "/watch/heart_rates/v1/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    watch-service-activities = {
      api = "/watch/activities/v1/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    watch-service-sleep = {
      api = "/watch/sleep/v1/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-activity = {
      api = "/luna/activity/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-heart = {
      api = "/luna/heart-rate/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-oxygen = {
      api = "/luna/oxygen/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-protean = {
      api = "/luna/protean/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-respiration = {
      api = "/luna/respiration/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-sleep = {
      api = "/luna/sleep/"
      domain = "uat-admin.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-temperature = {
      api = "/luna/temperature/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-vendors = {
      api = "/luna/vendors/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    luna-service-stress = {
      api = "/luna/stress/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }
    service-website-backend = {
      api = "/website/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    ae-service-activity = {
      api = "/ae/activities/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    ae-service-entreprise  = {
      api = "/ae/b2b/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    ae-service-steps = {
      api = "/ae/steps/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    fpe-service-activity = {
      api = "/fpe/activities/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    fpe-service-entreprise = {
      api = "/fpe/b2b/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    fpe-service-steps = {
      api = "/fpe/steps/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
     fpe-service-heart = {
      api = "/fpe/heart_rate/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    fpe-service-oxygen = {
      api = "/fpe/blood_oxygen/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    fpe-service-sleep = {
      api = "/fpe/sleep/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    fpe-service-stress = {
      api = "/fpe/stress/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-sleep = {
      api = "/bnd/sleep/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-entreprise = {
      api = "/bnd/b2b/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-heart = {
      api = "/bnd/heart/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-oxygen = {
      api = "/bnd/oxygen/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-steps = {
      api = "/bnd/steps/"
      domain = "uat-eks.abc.com"
      cpu_min     = "100m"
      cpu_max     = "300m"
      memory_min  = "100Mi"
      memory_max  = "500Mi"
      hpa_min     = 1
      hpa_avg_memory = "300Mi"
    }
    bnd-service-stress = {
      api = "/bnd/stress/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-activity = {
      api = "/bnd/activities/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }
    bnd-service-challenges = {
      api = "/bnd/challenges/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }    
    watch-service-stress = {
      api = "/watch/stress/v1/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }

    service-app-summary = {
      api = "/app_summary/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }

    service-content = {
      api = "/content/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-complaint = {
      api = "/connect/complaint/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-courier = {
      api = "/connect/courier/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-customer = {
      api = "/connect/customer/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "300Mi"
    }

    connect-service-master = {
      api = "/connect/master/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-message = {
      api = "/connect/message/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-product = {
      api = "/connect/product/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-record = {
      api = "/connect/record/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-distributor = {
      api = "/connect/distributor/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-sc-complaint = {
      api = "/connect/sc-complaint/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-user = {
      api = "/connect/user/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }

    connect-service-warranty = {
      api = "/connect/warranty/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }
    ae-service-stress = {
      api = "/ae/stress/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "200Mi"
      memory_max  = "800Mi"
      hpa_min     = 2
      hpa_avg_memory = "700Mi"
    }
    connect-client = {
      api = "/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "100Mi"
      memory_max  = "300Mi"
      hpa_min     = 2
      hpa_avg_memory = "250Mi"
    }
    eks-gateway = {
      api = "/gateway/"
      domain = "uat-eks.abc.com"
      cpu_min     = "200m"
      cpu_max     = "500m"
      memory_min  = "100Mi"
      memory_max  = "300Mi"
      hpa_min     = 2
      hpa_avg_memory = "250Mi"
    }
  }
}