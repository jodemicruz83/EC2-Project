# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "claro-terraform-tfstate-storage-nr17-home-office-prod"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}


terraform {
  source = "git@gitdev.clarobrasil.mobi:devops/modulos-terraform/modulos-aws/terraform-start-stop.git"
}

include {
  path = find_in_parent_folders()
}

# Inclusão de variáveis à Blueprint
inputs = {
    start_schedule_expression   = "cron(0 13 ? * MON-SUN *)"
    stop_schedule_expression    = "cron(0 22 ? * MON-SUN *)"
  

   tags = {

   }
}

# Generate an AWS provider block
generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite"
    contents = <<EOF
provider "aws" {
  region    = "sa-east-1"
  profile   = "prd-msteams"
}
provider "aws" {
  region    = "sa-east-1"
  alias     = "dns"
  profile   = "prd-ongoing"
}
EOF
}