output "id" {
  description = "ID da instância"
  value       = "${module.ec2.id[0]}"
}

output "ami" {
  description = "AMI da instância"
  value       = "${module.ec2.ami[0]}"
}

output "availability_zone" {
  description = "AZ onde a instância está provisionada"
  value       = "${module.ec2.availability_zone[0]}"
}

output "credit_specification" {
  description = "Especificação de créditos da instância"
  value       = "${module.ec2.credit_specification[0]}"
}

output "key_name" {
  description = "Key Pair da instância"
  value       = "${module.ec2.key_name[0]}"
}

output "vpc_security_group_ids" {
  description = "Lista de IDs dos security groups vinculados à instância"
  value       = "${module.ec2.vpc_security_group_ids[0]}"
}

output "subnet_id" {
  description = "ID da subnet onde a instância foi provisionada"
  value       = "${module.ec2.subnet_id[0]}"
}

output "primary_network_interface_id" {
  description = "ID da interface primária da instância"
  value       = "${module.ec2.primary_network_interface_id[0]}"
}

output "private_dns" {
  description = "DNS privado da instância"
  value       = "${module.ec2.private_dns[0]}"
}

output "private_ip" {
  description = "IP privado da instância"
  value       = "${module.ec2.private_ip[0]}"
}

output "public_dns" {
  description = "DNS público da instância"
  value       = "${module.ec2.public_dns[0]}"
}

output "public_ip" {
  description = "IP público da instância"
  value       = "${module.ec2.public_ip[0]}"
}
