module "ec2" {
  source = "../modules/terraform-ec2/"
  #source = "git::ssh://git@gitdev.clarobrasil.mobi/devops/modulos-terraform/modulos-aws/terraform-ec2.git?ref=master"

  name          = var.ec2_name
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  aws_iam_instance_profile = var.aws_iam_instance_profile
  key_name = "nr17"
  user_data = base64encode(data.template_file.instance_user_data.rendered)
  http_tokens = "optional"
  subnet_id              = var.ec2_subnet
  vpc_security_group_ids = [aws_security_group.main.id]
  associate_public_ip_address          = var.associate_public_ip_address

  root_block_device = [{
    volume_type = var.ec2_volume_type
    volume_size = var.ec2_size_volume
  }]

  ebs_block_device = [{
    device_name = var.ec2_device_name
    volume_type = var.ec2_volume_type
    volume_size = var.ec2_size_volume
  }]

  tags = var.tags
}

#Network Interface
resource "aws_network_interface" "eth1" {
  subnet_id       = var.ec2_subnet1
  security_groups = [aws_security_group.main.id]

  attachment {
    instance     = module.ec2.id[0]
    device_index = 1
  }
}
resource "aws_network_interface" "eth2" {
  subnet_id       = var.ec2_subnet2
  security_groups = [aws_security_group.main.id]

  attachment {
    instance     = module.ec2.id[0]
    device_index = 2
  }
}
resource "aws_network_interface" "eth3" {
  subnet_id       = var.ec2_subnet3
  security_groups = [aws_security_group.main.id]

  attachment {
    instance     = module.ec2.id[0]
    device_index = 3
  }
}
#Network Interface

#Elastic IP
resource "aws_eip_association" "eip_assoc" {
  count         = var.aws_eip_ec2_public_ip_count
  instance_id   = module.ec2.id[0]
  allocation_id = aws_eip.ec2_public_ip[0].id
}
resource "aws_eip" "ec2_public_ip" {
  count = var.aws_eip_ec2_public_ip_count
  vpc   = true
}
#Security Group
resource "aws_security_group" "main" {
  name        = "${var.ec2_name}-sg"
  description = "EC2 default security group."
  vpc_id      = var.ec2_vpc
  tags        = var.tags
}
resource "aws_security_group_rule" "ec2_egress" {
  description       = "Allow EC2 egress access to the Internet."
  protocol          = "-1"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  type              = "egress"
}
resource "aws_security_group_rule" "ec2_ingress" {
  description       = "Allow to communicate with the EC2 instance."
  protocol          = "tcp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_ingress
  from_port         = var.port_ec2_ingress_from
  to_port           = var.port_ec2_ingress_to
  type              = "ingress"
}
# resource "aws_security_group_rule" "ec2_local_ingress" {
#   description       = "Allow pods to communicate local."
#   protocol          = "tcp"
#   security_group_id = aws_security_group.main.id
#   cidr_blocks       = var.cidr_blocks_local_ingress
#   from_port         = var.port_ec2_local_ingress
#   to_port           = var.port_ec2_local_ingress
#   type              = "ingress"
# }
resource "aws_security_group_rule" "ec2_local_ingress_http" {
  description       = "Allow pods to communicate local."
  protocol          = "tcp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_local_ingress_http
  from_port         = var.port_ec2_local_ingress_http
  to_port           = var.port_ec2_local_ingress_http
  type              = "ingress"
}
resource "aws_security_group_rule" "ec2_local_ingress_https" {
  description       = "Allow pods to communicate local."
  protocol          = "tcp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_local_ingress_https
  from_port         = var.port_ec2_local_ingress_https
  to_port           = var.port_ec2_local_ingress_https
  type              = "ingress"
}
resource "aws_security_group_rule" "eom_all" {
  description       = "EOM all to SCB ECB"
  protocol          = "all"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_local_ingress_eom_all
  from_port         = var.port_ec2_local_ingress_from_eom_all
  to_port           = var.port_ec2_local_ingress_to_eom_all
  type              = "ingress"
}
resource "aws_security_group_rule" "sip_ebt" {
  description       = "sip ebt to sbc"
  protocol          = "tcp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_local_ingress_sip_ebt
  from_port         = var.port_ec2_local_ingress_from_sip_ebt
  to_port           = var.port_ec2_local_ingress_to_sip_ebt
  type              = "ingress"
}
resource "aws_security_group_rule" "rtb" {
  description       = "rtb to sbc"
  protocol          = "udp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_local_ingress_rtb
  from_port         = var.port_ec2_local_ingress_from_rtb
  to_port           = var.port_ec2_local_ingress_to_rtb
  type              = "ingress"
}
resource "aws_security_group_rule" "ebt_udp" {
  description       = "ebt_udp"
  protocol          = "udp"
  security_group_id = aws_security_group.main.id
  cidr_blocks       = var.cidr_blocks_local_ingress_ebt_udp
  from_port         = var.port_ec2_local_ingress_from_ebt_udp
  to_port           = var.port_ec2_local_ingress_to_ebt_udp
  type              = "ingress"
}
# USER DATA
# -------->

data "template_file" "instance_user_data" {
  template = <<EOF
Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0

#!/bin/bash
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl status amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl status amazon-ssm-agent
--==BOUNDARY==--

EOF
}
# -------->
# USER DATA

#DNS ip privado
#resource "aws_route53_record" "wwww" {
#provider = aws.dns
#zone_id = "Z1AZWYUQBHY9CK"
#name = "${var.ec2_name}-prd.clarobrasil.mobi"
#type = "CNAME"
#ttl = "60"
#records = [module.ec2.private_ip[0]]
#}

# resource "aws_route53_record" "www" {
# provider = aws.dns
# zone_id = "Z1AZWYUQBHY9CK"
# name = "api-sbc-ha-prd.clarobrasil.mobi"
# type = "CNAME"
# ttl = "60"
# records = [aws_eip.ec2_public_ip[0].public_dns]
# }

###########################
resource "aws_iam_role" "ec2_service_role" {
  name                  = "${var.ec2_name}prd-nr17-ec2_service-role"
  force_detach_policies = "true"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ssm.amazonaws.com"
        ]
      }
    }
  ]
}
EOF

#  tags = "${merge(map("Name", "prd-nr17"), var.tags)}"
}

################################################
# List the actions needed to execute the tasks #
################################################

data "aws_iam_policy_document" "ec2_service_role" {

  
  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
      "ec2:DescribeAddresses",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeNetworkInterfaceAttribute",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeSubnets",
      "ec2:AssignPrivateIpAddresses",
      "ec2:AssociateAddress",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstanceStatus"
    ]
    effect    = "Allow"
    resources = ["*"]
    sid = "VisualEditor0"
  }
}

resource "aws_iam_policy" "ec2_service_policy" {
  name   = "${var.ec2_name}prd-nr17-ec2_service-policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.ec2_service_role.json}"
}

#####################################
# Attach policy to the service role #
#####################################


resource "aws_iam_policy_attachment" "ec2_service_role_atachment_policy_vpc" {
 name       = "ec2_service_role-nr17-policy-attachment-vpc"
 roles      = ["${aws_iam_role.ec2_service_role.name}"]
 policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}
resource "aws_iam_policy_attachment" "ec2_service_role_atachment_policy_AWSServiceRoleForBackup" {
 name       = "ec2_service_role-nr17-policy-attachment-AWSServiceRoleForBackup"
 roles      = ["${aws_iam_role.ec2_service_role.name}"]
 policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

##############################################################
# Create intance profile to be used on ec2 instance creation #
##############################################################
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.ec2_name}prd-nr17-ec2-instance-profile"
  role = "${aws_iam_role.ec2_service_role.name}"
}
