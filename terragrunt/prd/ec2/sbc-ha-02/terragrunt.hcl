terraform {
  source = "../../../../terraform-blueprints/ec2-3eth/"
}

include {
  path = find_in_parent_folders()
}

# Inclusão de variáveis à Blueprint
inputs = {
    ec2_name            = "sbc-ha-02"
    ec2_instance_type   = "c4.xlarge"
    aws_iam_instance_profile = "sbc-ha-02prd-nr17-ec2-instance-profile"
    ec2_subnet          = "subnet-01c4fdae102576759" # public subnet1 - 172.26.58.0/26
    ec2_subnet1         = "subnet-0190717ea2f185959" # private subnet1 - 172.26.58.128/26
    ec2_subnet2         = "subnet-07cb71c1af525a3a5" # private subnet2 - 172.26.58.192/26
    ec2_subnet3         = "subnet-041ad18c0a1904a0e" # public subnet2 - 172.26.58.64/26 
    ec2_vpc             = "vpc-0a0e6ee83334afc6c"
    #ec2_ami             = "ami-08b270a9e4bd91b9b" #inicial OL8.5-x86_64-HVM-2021-11-24
    #ec2_ami             = "ami-06b44ebe65d8c2190" #inicial OL7.9-x86_64-HVM-2020-12-07
    ec2_ami             = "ami-074088741b12b98dd" #gerada AMI-Oracle8-NR17
    ec2_size_volume     = 20
    ec2_key_name        = "nr17"
    aws_eip_ec2_public_ip_count = "0"
    cidr_blocks_ingress = ["189.52.216.39/32"]
    port_ec2_ingress_from    = "5060"
    port_ec2_ingress_to    = "5061"
    cidr_blocks_local_ingress_rtb = ["52.112.0.0/14","52.120.0.0/14"]
    port_ec2_local_ingress_from_rtb = "49152"
    port_ec2_local_ingress_to_rtb = "53247"
    cidr_blocks_local_ingress_sip_ebt = ["52.112.0.0/14","52.120.0.0/14"]
    port_ec2_local_ingress_from_sip_ebt = "5060"
    port_ec2_local_ingress_to_sip_ebt = "5070"
    cidr_blocks_local_ingress_http = ["172.26.58.0/24","177.189.250.238/32","5.8.108.90/32","201.6.19.47/32"]
    port_ec2_local_ingress_http = "80"
    cidr_blocks_local_ingress_https = ["172.26.58.0/24","177.189.250.238/32","5.8.108.90/32","201.6.19.47/32"]
    port_ec2_local_ingress_https = "443"
    cidr_blocks_local_ingress_eom_all = ["172.26.58.0/24"]
    port_ec2_local_ingress_from_eom_all = "0"
    port_ec2_local_ingress_to_eom_all = "65535"
    cidr_blocks_local_ingress_ebt_udp = ["189.86.151.229/32"]
    port_ec2_local_ingress_from_ebt_udp = "16384"
    port_ec2_local_ingress_to_ebt_udp = "65535"
    associate_public_ip_address = true

   tags = {
       Name            = "sbc-ha-02"
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
       AutoStop        = "true"
   }
}