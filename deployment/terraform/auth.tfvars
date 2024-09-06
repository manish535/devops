s3_bucket               = "noise-iac-statefile-tf"
region                  = "ap-south-1"
s3_encryption           = true
shared_credentials_file = "/var/lib/jenkins/.aws/credentials"
shared_config_files     = "/var/lib/jenkins/.aws/config"
profile                 = "devops_925332100543"
dynamodb_table          = "tf-deployment-stage"
s3_bucket_key           = "eks/deployment/stage/tf-deployment-stage.tfstate"