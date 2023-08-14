output "id" {
  description = "Lista dos IDs das instâncias"
  value       = aws_instance.main.*.id
}

output "ami" {
  description = "Lista das AMIs das instâncias"
  value       = aws_instance.main.*.ami
}

output "availability_zone" {
  description = "Lista das AZs das instâncias"
  value       = aws_instance.main.*.availability_zone
}

output "credit_specification" {
  description = "Lista das especificações de créditos das instâncias"
  value       = aws_instance.main.*.credit_specification
}

output "key_name" {
  description = "Lista dos Key Pairs das instâncias"
  value       = aws_instance.main.*.key_name
}

output "vpc_security_group_ids" {
  description = "Lista dos IDs dos security groups vinculados às instâncias"
  value       = aws_instance.main.*.vpc_security_group_ids
}

output "subnet_id" {
  description = "Lista dos IDs das subnets das instâncias"
  value       = aws_instance.main.*.subnet_id
}

output "primary_network_interface_id" {
  description = "Lista dos IDs das interfaces primárias das instâncias"
  value       = aws_instance.main.*.primary_network_interface_id
}

output "private_dns" {
  description = "Lista dos endereços DNS privados das instâncias"
  value       = aws_instance.main.*.private_dns
}

output "private_ip" {
  description = "Lista dos IPs privados das instâncias"
  value       = aws_instance.main.*.private_ip
}

output "public_dns" {
  description = "Lista dos endereços DNS públicos das instâncias"
  value       = aws_instance.main.*.public_dns
}

output "public_ip" {
  description = "Lista dos IPs públicos das instâncias"
  value       = aws_instance.main.*.public_ip
}

output "ssm_enabled" {
  description = "Se o AWS SSM Session Manager está habilitado nas instâncias"
  value       = var.enable_ssm
}

