# by default, use local state file but this is not practical. 

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "local" {
    path = ".terraform_backend/terraform.tfstate"
  }
}
EOF
}

# Below is an example of using S3 as a remote state backend.
# Terragrunt will automatically configure the remote state for you.
# remote_state {
#   backend = "s3"
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite"
#   }
#   config = {
#     bucket         = "my-terraform-state"
#     key            = "${path_relative_to_include()}/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "my-lock-table"
#   }
# }

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = "1.9.5"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.97.0"
    }
  }
}

provider "snowflake" {
  alias = "accountadmin"
  role  = "ACCOUNTADMIN"
}
EOF
}
