terraform {
  required_version = "~>1.4.0"

  backend "s3" {
    bucket                  = "iac-statefile-tf-2430"
    key                     = "eks/development/tf-eks-development-state.tfstate"
    encrypt        	        = true
    region                  = "ap-south-1"
    dynamodb_table          = "tf-eks-development"
    shared_credentials_file = "/Users/manish/.aws/credentials"
    profile                 = "devops_608762072430"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
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

  default_tags {
    tags = {
      iac_environment = var.iac_environment_tag
    }
  }
}