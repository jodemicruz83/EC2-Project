# ----------------------------------------------------------------------------------------------------------------------
# EC2
# ----------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "main" {
  count = var.instance_count

  ami                  = var.ami
  instance_type        = var.instance_type
  user_data            = var.user_data
  key_name             = var.key_name
  iam_instance_profile = var.aws_iam_instance_profile

  subnet_id = element(
    distinct(compact(concat([var.subnet_id], var.subnet_ids))),
    count.index,
  )

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = var.http_tokens
  }

  #private_ip                  = var.private_ip
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.vpc_security_group_ids

  monitoring              = var.monitoring
  disable_api_termination = var.disable_api_termination
  source_dest_check       = var.source_dest_check

  credit_specification {
    cpu_credits = var.cpu_credits
  }

  ebs_optimized = var.ebs_optimized
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      device_name           = ebs_block_device.value.device_name
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
    }
  }

  tags = var.tags

  volume_tags = var.tags
}

# Select user specified instance profile or the default one created (see below)
# data "aws_iam_instance_profile" "being_used" {
#  name = var.iam_instance_profile != "" ? var.iam_instance_profile : join("", aws_iam_instance_profile.ec2_instance_profile.*.id)
# }

# ----------------------------------------------------------------------------------------------------------------------
# IAM
# ----------------------------------------------------------------------------------------------------------------------

# Default instance profile, role and policy document if instance profile is not specified
#resource "aws_iam_instance_profile" "default" {
#  count = var.iam_instance_profile != "" ? 0 : 1

#   role = aws_iam_role.default[0].name
#}

#resource "aws_iam_role" "default" {
#  count = var.iam_instance_profile != "" ? 0 : 1

#  assume_role_policy = data.aws_iam_policy_document.allow_ec2_to_assume_role.json
#}

#data "aws_iam_policy_document" "allow_ec2_to_assume_role" {
#  statement {
#    actions = ["sts:AssumeRole"]

 #   principals {
 #     type        = "Service"
 #     identifiers = ["ec2.amazonaws.com"]
  #  }
  #}
#}

# ----------------------------------------------------------------------------------------------------------------------
# SSM ACCESS
# ----------------------------------------------------------------------------------------------------------------------

# Attaches default Amazon policy for SSM
#resource "aws_iam_role_policy_attachment" "ssm_policy" {
#  count = var.enable_ssm ? 1 : 0

#  role       = data.aws_iam_instance_profile.being_used.role_name
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
#}


