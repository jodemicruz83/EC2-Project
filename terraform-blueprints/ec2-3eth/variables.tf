variable "aws_iam_instance_profile" {
  description = "Name of instance"
  type        = string
}
variable "ec2_name" {
  description = "Name of instance"
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID of instance"
  type        = string
  default     = "ami-0c2b8ca1dad447f8a"
}

variable "ec2_instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t3.nano"
}

variable "ec2_vpc" {
  description = "Desired VPC"
  type        = string
}

variable "ec2_subnet" {
  description = "Desired public or private subnet"
  type        = string
}

variable "ec2_subnet1" {
  description = "Desired public or private subnet"
  type        = string
}

variable "ec2_subnet2" {
  description = "Desired public or private subnet"
  type        = string
}

variable "ec2_subnet3" {
  description = "Desired public or private subnet"
  type        = string
}

variable "ec2_volume_type" {
  description = "Disk type of instance"
  type        = string
  default     = "gp2"
}

variable "ec2_device_name" {
  description = "Name of mount point inside the instance"
  type        = string
  default     = "/dev/xvdb"
}

variable "ec2_size_volume" {
  description = "Size of EBS volume"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Default TAGs of all resources"
  type        = map(string)
  default     = {}
}
variable "cidr_blocks_ingress" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_ingress_from" {
  description = "ports for ingress"
  type        = number
}
variable "port_ec2_ingress_to" {
  description = "ports for ingress"
  type        = number
}
# variable "cidr_blocks_local_ingress" {
#   description = "block ips for ingress"
#   type        = list
# }
# variable "port_ec2_local_ingress" {
#   description = "ports for ingress"
#   type        = number
# }
variable "cidr_blocks_local_ingress_http" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_local_ingress_http" {
  description = "ports for ingress"
  type        = number
}
variable "cidr_blocks_local_ingress_https" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_local_ingress_https" {
  description = "ports for ingress"
  type        = number
}
variable "cidr_blocks_local_ingress_eom_all" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_local_ingress_from_eom_all" {
  description = "ports for ingress"
  type        = number
}
variable "port_ec2_local_ingress_to_eom_all" {
  description = "ports for ingress"
  type        = number
}
variable "cidr_blocks_local_ingress_sip_ebt" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_local_ingress_from_sip_ebt" {
  description = "ports for ingress"
  type        = number
}
variable "port_ec2_local_ingress_to_sip_ebt" {
  description = "ports for ingress"
  type        = number
}
variable "cidr_blocks_local_ingress_rtb" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_local_ingress_from_rtb" {
  description = "ports for ingress"
  type        = number
}
variable "port_ec2_local_ingress_to_rtb" {
  description = "ports for ingress"
  type        = number
}
variable "cidr_blocks_local_ingress_ebt_udp" {
  description = "block ips for ingress"
  type        = list
}
variable "port_ec2_local_ingress_from_ebt_udp" {
  description = "ports for ingress"
  type        = number
}
variable "port_ec2_local_ingress_to_ebt_udp" {
  description = "ports for ingress"
  type        = number
}
variable "aws_eip_ec2_public_ip_count" {
  description = "Publics Ips"
  type        = number
  default     = 1
}
variable "iam_instance_profile" {
  description = "Instance Profile do IAM vinculado à instância"
  default     = ""
}
variable "associate_public_ip_address" {
  description = "public ip"
  type        = string
  default     = false
}
