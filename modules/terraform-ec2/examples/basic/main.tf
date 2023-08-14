provider "aws" {
  region = "us-east-1"
}

# ----------------------------------------------------------------------------------------------------------------------
# Data sources
# ----------------------------------------------------------------------------------------------------------------------

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.default.id}"

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# EC2 Instance
# ----------------------------------------------------------------------------------------------------------------------

module "ec2" {
  source = "../../"

  name          = "TF - EC2 Module - Basic Example"
  ami           = "${data.aws_ami.amazon_linux_2.image_id}"
  instance_type = "t3.micro"

  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, 0)}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${data.aws_security_group.default.id}"]

  ebs_optimized = false

  root_block_device = [{
    volume_type = "gp2"
    volume_size = 8
  }]

  tags {
    Environment = "tf-ec2-module-tests"
    Terraform   = "true"
  }
}
