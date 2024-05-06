resource "aws_ssm_parameter" "db_host" {
  name  = "/${var.project_name}/db_host"
  value = aws_db_instance.default.endpoint
  type  = "String"
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/${var.project_name}/db_name"
  value = var.db_name
  type  = "String"
}

resource "aws_ssm_parameter" "db_username" {
  name  = "/${var.project_name}/db_username"
  value = var.db_username
  type  = "String"
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.project_name}/db_password"
  value = var.db_password
  type  = "SecureString" # Important to store the password securely in SSM
}
