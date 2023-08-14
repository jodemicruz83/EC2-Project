terraform {
  source = "../../../../terraform-blueprints/ec2-2eth/"
}

include {
  path = find_in_parent_folders()
}

# Inclusão de variáveis à Blueprint
inputs = {
    ec2_name            = "eom"
    ec2_instance_type   = "c6i.2xlarge"
    aws_iam_instance_profile = "eomprd-nr17-ec2-instance-profile"
    ec2_subnet          = "subnet-01c4fdae102576759" # public subnet1 - 172.26.58.0/26
    ec2_subnet1         = "subnet-0190717ea2f185959" # private subnet1 - 172.26.58.128/26
    ec2_subnet2         = "subnet-07cb71c1af525a3a5" # private subnet2 - 172.26.58.192/26
    ec2_vpc             = "vpc-0a0e6ee83334afc6c"
    ec2_ami             = "ami-0b22486146c6974f9"
    ec2_size_volume     = "1024"
    ec2_key_name        = "nr17"
    aws_eip_ec2_public_ip_count = "0"
    # cidr_blocks_ingress = ["172.26.58.0/24"]
    # port_ec2_ingress    = "22"
    # cidr_blocks_local_ingress = ["172.26.58.0/24"]
    # port_ec2_local_ingress = "4739"
    cidr_blocks_local_ingress_http = ["189.51.183.52/32","172.26.58.0/24","177.189.250.238/32","5.8.108.90/32","201.6.19.45/32","201.6.19.46/32","201.6.19.47/32","201.6.19.48/32","201.6.19.49/32","201.6.19.50/32"]
    port_ec2_local_ingress_http = "80"
    cidr_blocks_local_ingress_https = ["189.51.183.52/32","172.26.58.0/24","177.189.250.238/32","5.8.108.90/32","201.6.19.45/32","201.6.19.46/32","201.6.19.47/32","201.6.19.48/32","201.6.19.49/32","201.6.19.50/32"]
    port_ec2_local_ingress_https = "443"
    cidr_blocks_local_ingress_eom_all = ["172.26.58.0/24"]
    port_ec2_local_ingress_from_eom_all = "0"
    port_ec2_local_ingress_to_eom_all = "65535"
    associate_public_ip_address = true



   tags = {
       Name            = "eom"
       Backup          = "true"
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