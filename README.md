# terraform-rds
Repositório destinado a criação de uma RDS Pública usando Terraform

Para que funcione corretamente é necessário criar um bucket no S3.

Para chamar local deve passar o DB_PASSWORD

TF_VAR_db_password=xxxxxxx terraform apply
