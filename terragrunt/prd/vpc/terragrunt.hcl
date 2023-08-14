include {
  path = find_in_parent_folders()
}

inputs = {
    vpc_cidr_block = "172.26.58.0/24"
    public_subnet1_cidr_block = "172.26.58.0/26"
    public_subnet2_cidr_block = "172.26.58.64/26"
    private_subnet1_cidr_block = "172.26.58.128/26"
    private_subnet2_cidr_block = "172.26.58.192/26"
    availability_zone1 = "sa-east-1a"
    availability_zone2 = "sa-east-1a"

    tags = {
     ambiente        = "prd"
     torre           = "ti"
     marca           = "claro"
     centro-de-custo = "10MZBR7H35"
     projeto         = "NR17 - HomeOffice Full"
     servico         = "vpc"
     conta           = "prd-msteams"
     plataforma      = "aws"
     produto         = "nr17"
   }
}

terraform {
  source = "git::git@gitdev.clarobrasil.mobi:devops/manchestergit/terraform/modules/vpc.git//module?ref=v0.1.0"

  extra_arguments "custom_vars" {
    commands = [
        "apply",
        "plan",
        "import",
        "push",
        "refresh"
    ]

    #arguments = [
    #  "-var-file=${get_terragrunt_dir()}/${path_relative_from_include()}/inventory/${get_env("ENV")}/vpc.tfvars",
    #]
  }
}
