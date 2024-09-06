s3_bucket               = "noise-iac-statefile-tf"
region                  = "ap-south-1"
s3_encryption           = true
shared_credentials_file = "/Users/manish/.aws/credentials"
shared_config_files     = "/Users/manish/.aws/config"
profile                 = "devops_925332100543"
dynamodb_table          = "tf-eks-production"
s3_bucket_key           = "eks/production/tf-eks-production.tfstate"