terraform {
  source = "../../../../terraform-blueprints/ec2/"
}

include {
  path = find_in_parent_folders()
}

# Inclusão de variáveis à Blueprint
inputs = {
    ec2_name            = "ami-base-01"
    ec2_instance_type   = "t2.medium"
    ec2_subnet          = "subnet-01c4fdae102576759"
    ec2_subnet1          = "subnet-01c4fdae102576759"
    ec2_vpc             = "vpc-0a0e6ee83334afc6c"
    #ec2_ami             = "ami-08b270a9e4bd91b9b" #inicial oracle 8
    #ec2_ami             = "ami-06b44ebe65d8c2190" #inicial oracle 7.9
    ec2_ami             =  "ami-0ed6bb2ab4e8d0823"
    ec2_size_volume     = 500
    ec2_key_name        = "nr17"
    cidr_blocks_ingress = ["187.104.193.96/32", "201.150.49.94/32", "10.88.0.31/32"]
    port_ec2_ingress    = 22
    cidr_blocks_local_ingress = ["172.26.58.0/24"]
    port_ec2_local_ingress = 8080
    cidr_blocks_local_ingress_http = ["177.189.250.238/32"]
    port_ec2_local_ingress_http = 80
    cidr_blocks_local_ingress_https = ["177.189.250.238/32"]
    port_ec2_local_ingress_https = 443
    associate_public_ip_address = true



   tags = {
       Name        = "ami-base"
       Backup      = "true"
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