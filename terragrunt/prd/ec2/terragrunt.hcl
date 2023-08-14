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


inputs = {
   aws_region = "sa-east-1"
   project_name = "nr17-home-office"
   env = "prd"
   account_id = "604660094669"

  #  vpc_id = "vpc-0bc6ff2448d3c3ed7" # VPC_MIND_STG_PRD
  #  private_subnet1_id = "subnet-0e9335b9a65422245" # priv_mind_all_app_stg_useast1b
  #  private_subnet2_id = "subnet-01a5788a53ab87633" # priv_mind_all_app_stg_useast1b
  #  public_subnet1_id = "subnet-0059f67a2a305a8b9" # pub_mind_all_dmz_stg_useast1a
  #  public_subnet2_id = "subnet-0f23b6a0b0bf23387" # pub_mind_all_dmz_stg_useast1b

  tags = {
     ambiente        = "prd"
     torre           = "ti"
     marca           = "claro"
     centro-de-custo = "10MZBR7H35"
     projeto         = "nr17-homeoffice-full"
     servico         = "vpc"
     conta           = "prd-msteams"
     plataforma      = "aws"
     produto         = "nr17-homeoffice-full"
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

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------
# Configure root level variables that all resources can inherit.
# inputs = merge(
#   local.account_vars.locals,
#   local.region_vars.locals,
# )