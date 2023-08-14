# Módulo Terraform - AWS - EC2

Módulo do Terraform para provisionamento de instâncias do Amazon Elastic Compute Cloud ([EC2][ec2-docs]).

[ec2-docs]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html

## Uso

```hcl
module "ec2" {
  source = "git::ssh://git@example.com/terraform-modules/aws/ec2.git?ref=v2.0.0"

  name          = "TF - exemplo EC2"
  ami           = "ami-abcd1234"
  instance_type = "t3.medium"

  subnet_id              = "subnet-abcd1234"
  vpc_security_group_ids = ["sg-abcd1234"]

  root_block_device = [{
    volume_type = "gp2"
    volume_size = 20
  }]

  ebs_block_device = [{
    device_name         = "/dev/xvdb"
    volume_type         = "gp2"
    volume_size         = 10
  }]

  tags {
    Environment = "tf-testes"
    Role        = "Exemplo_EC2"
  }
}
```

## Recursos provisionados

- EC2 Instance
- Attach da policy `AmazonEC2RoleforSSM` na Role da EC2 Instance
    - É criada também uma Role caso o usuário não defina uma Instance Profile

## Customizações

### Instâncias em múltiplas subnets

Para provisionar várias instâncias em múltiplas subnets, utilize a variável `subnet_ids`.

> **Atenção!** Você **DEVE** definir ao menos uma das variáveis `subnet_id` ou
> `subnet_ids`.
> Caso ambas sejam configuradas, o valor de `subnet_id` precederá a lista de `subnet_ids`.

```hcl
module "ec2" {
  # ...

  instance_count = 3

  subnet_ids = ["subnet-abc123", "subnet-def456", "subnet-654321"]
}
```

### Créditos de CPU

Caso a instância seja do tipo T2 ou T3, a variável `cpu_credits` pode ser usada
para habilitar o modo [T2/T3 Unlimited][t-unlimited-docs]:

```hcl
module "ec2" {
  # ...

  cpu_credits = "unlimited"
}
```

[t-unlimited-docs]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html

### Número de instâncias

Use a variável `instance_count` caso precise provisionar mais de uma instância:

```hcl
module "myapp-cluster" {
  # ...

  name           = "MyApp-Cluster"
  instance_count = 5
}
```

## Exemplos

- [Instância EC2 básica](examples/basic/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | ID da AMI usada para provisionar a instância | `any` | n/a | yes |
| associate\_public\_ip\_address | Vincula um IP público à instância | `bool` | `false` | no |
| cpu\_credits | Opção de créditos de CPU da instância ("unlimited" ou "standard") | `string` | `"standard"` | no |
| disable\_api\_termination | Controla a proteção de destruição (terminate) da instância | `bool` | `false` | no |
| ebs\_block\_device | Lista com maps de configuração de volumes adicionais da instância | `list` | `[]` | no |
| ebs\_optimized | Controla se a instância será provisionada como EBS-optimized | `bool` | `false` | no |
| enable\_ssm | Habilita o AWS SSM Session Manager. Essa é uma forma mais segura de conexão à instância do que a conexão por SSH | `bool` | `true` | no |
| iam\_instance\_profile | Instance Profile do IAM vinculado à instância | `string` | `""` | no |
| instance\_count | Número de instâncias que serão provisionadas | `number` | `1` | no |
| instance\_type | Tipo (classe) da instância | `any` | n/a | yes |
| key\_name | Nome do Key Pair a ser usado para a instância | `string` | `""` | no |
| monitoring | Controla se a instância terá monitoramento detalhado | `bool` | `false` | no |
| name | Nome da instância | `any` | n/a | yes |
| private\_ip | IP privado da instância na VPC | `string` | `""` | no |
| root\_block\_device | Lista com maps de configuração do volume raiz da instância | `list` | n/a | yes |
| source\_dest\_check | Controla se o tráfego é roteado para a instância quando o endereço de destino não é o mesmo da instância | `bool` | `true` | no |
| subnet\_id | ID da subnet onde a instância será provisionada | `string` | `""` | no |
| subnet\_ids | Lista com IDs das subnets onde a instância será provisionada | `list` | `[]` | no |
| tags | Map de tags da instância e dos volumes | `map` | `{}` | no |
| user\_data | User data utilizado ao provisionar a instância | `string` | `""` | no |
| vpc\_security\_group\_ids | Lista com IDs dos security groups que serão vinculados à instância | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ami | Lista das AMIs das instâncias |
| availability\_zone | Lista das AZs das instâncias |
| credit\_specification | Lista das especificações de créditos das instâncias |
| id | Lista dos IDs das instâncias |
| key\_name | Lista dos Key Pairs das instâncias |
| primary\_network\_interface\_id | Lista dos IDs das interfaces primárias das instâncias |
| private\_dns | Lista dos endereços DNS privados das instâncias |
| private\_ip | Lista dos IPs privados das instâncias |
| public\_dns | Lista dos endereços DNS públicos das instâncias |
| public\_ip | Lista dos IPs públicos das instâncias |
| ssm\_enabled | Se o AWS SSM Session Manager está habilitado nas instâncias |
| subnet\_id | Lista dos IDs das subnets das instâncias |
| vpc\_security\_group\_ids | Lista dos IDs dos security groups vinculados às instâncias |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Acesso a instância com AWS SSM Session Manager

Para acessar a instância com o SSM é preciso instalar o [Plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) do session manager e utilizar a [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/ssm/start-session.html) ou utilizar o [console](https://console.aws.amazon.com/systems-manager/session-manager) da AWS.