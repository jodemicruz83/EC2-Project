# Instância EC2 básica

Exemplo de criação de uma instância EC2 básica.

## Uso

Para aplicar este exemplo, execute:

```console
$ terraform init
$ terraform plan
$ terraform apply
```

Quando conveniente, remova os recursos criados:

```console
$ terraform destroy
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| ami | AMI da instância |
| availability\_zone | AZ onde a instância está provisionada |
| credit\_specification | Especificação de créditos da instância |
| id | ID da instância |
| key\_name | Key Pair da instância |
| primary\_network\_interface\_id | ID da interface primária da instância |
| private\_dns | DNS privado da instância |
| private\_ip | IP privado da instância |
| public\_dns | DNS público da instância |
| public\_ip | IP público da instância |
| subnet\_id | ID da subnet onde a instância foi provisionada |
| vpc\_security\_group\_ids | Lista de IDs dos security groups vinculados à instância |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
