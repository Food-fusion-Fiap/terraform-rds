# resource "aws_db_instance" "rds_postgresql" {
#   allocated_storage    = 20
#   engine               = "aurora-postgresql"
#   engine_version       = "15.4"
#   instance_class       = "db.t3.small"
#   username             = "admin"
#   password             = "yourpassword"
#   db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

#   tags = {
#     Name = "Aurora PostgreSQL"
#   }
# }

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.2"
  instance_class       = "db.t3.micro"
  identifier           = "postgres"
  db_name              = "postgres"
  username             = "postgres"
  password             = "foobarbaz"
  parameter_group_name = "default.postgres16"
  publicly_accessible  = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.allow_postgres.id] # Just for demonstration purposes
  skip_final_snapshot    = true

  tags = {
    Name = "RDS PostgreSQL"
  }
}
