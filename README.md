# terraform-rds

Este repositório destina-se à criação de uma infraestrutura básica na AWS usando Terraform, incluindo uma Virtual Private Cloud (VPC), Subnet, Internet Gateway (IGW) e um Banco de Dados Relacional (RDS) Público.

## Instalação e Configuração

Antes de usar este repositório, certifique-se de ter o Terraform instalado localmente. Você pode encontrar instruções de instalação na [documentação oficial do Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

Depois de instalar o Terraform, configure suas credenciais da AWS utilizando as variáveis de ambiente `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`.

## Componentes

- **VPC (Virtual Private Cloud)**: Uma rede virtual isolada na AWS para lançar seus recursos de computação.
- **Subnet**: Segmentos da rede VPC em uma ou mais zonas de disponibilidade na região da AWS.
- **Internet Gateway (IGW)**: Um ponto de conexão entre uma VPC e a internet.
- **RDS Público**: Um banco de dados relacional gerenciado pela AWS que é acessível publicamente.

## Variáveis de Ambiente

Além das variáveis de ambiente padrão do Terraform, você também pode configurar as seguintes variáveis para personalizar o comportamento da infraestrutura:

- `TF_VAR_db_password`: Senha do banco de dados RDS.

## Instruções de Uso

1. Clone este repositório em sua máquina local.
2. Configure suas credenciais da AWS.
3. Defina as variáveis de ambiente necessárias, como `TF_VAR_db_password`.
4. Execute `terraform init` para inicializar o diretório do Terraform.
5. Execute `terraform plan` para visualizar as alterações planejadas.
6. Execute `terraform apply` para aplicar as alterações e criar os recursos na AWS.

## Exemplos de Código

Veja abaixo um exemplo de código Terraform para criar uma VPC:

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}
```

## Considerações de Segurança

Lembre-se de seguir as melhores práticas de segurança ao usar o Terraform para provisionar recursos na AWS. Isso inclui o gerenciamento seguro de credenciais e o controle de acesso adequado aos recursos.

## Modelagem do banco de dados
![image](https://github.com/Food-fusion-Fiap/terraform-rds/assets/71785908/b613d8a6-fe0c-497a-8ccd-6e2bd4526911)

## FAQ

**P: Como faço para acessar o banco de dados RDS criado?**

R: Você pode encontrar o endpoint de conexão na saída do Terraform após a criação bem-sucedida dos recursos.

**P: Posso personalizar os parâmetros do banco de dados RDS?**

R: Sim, você pode definir várias opções de configuração para o banco de dados RDS no arquivo Terraform.

Para mais perguntas, consulte a [documentação oficial do Terraform](https://www.terraform.io/docs/index.html).
