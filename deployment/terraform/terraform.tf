terraform {
  required_version = "~>1.4.0"

  #backend "s3" {
  #  bucket                  = "noise-iac-statefile-tf"
  #  key                     = "eks/deployment/stage/tf-deployment-stage.tfstate"
  #  encrypt        	        = true
  #  region                  = "ap-south-1"
  #  dynamodb_table          = "tf-deployment-stage"
  #  shared_credentials_file = "/var/lib/jenkins/.aws/credentials"
  #  profile                 = "devops_925332100543"
  #}
  backend "local" {}
  required_providers {
    #aws = {
    #  source  = "hashicorp/aws"
    #  version = "4.64.0"
    #}
    #kubernetes = {
    #  source  = "hashicorp/kubernetes"
    #  version = "2.20.0"
    #}
    #helm = {
    #  source  = "hashicorp/helm"
    #  version = "2.9.0"
    #}
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 3.3.0"
    }
  }
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN

provider "aws" {
  shared_config_files      = [var.shared_config_files]
  shared_credentials_files = [var.shared_credentials_file]
  profile                  = var.profile
  region                   = var.region
}