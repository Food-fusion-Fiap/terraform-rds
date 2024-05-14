# Criação da VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main"
  }
}

# Criação da sub-rede pública
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Criação da sub-rede pública
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet2"
  }
}

# Criação da sub-rede privada
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet"
  }
}

# Gateway de internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Criação de uma tabela de rotas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associação da tabela de rotas pública à sub-rede pública
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

# Associação da tabela de rotas pública à sub-rede pública
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public2.id
}

# Criação de uma tabela de rotas privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

# Associação da tabela de rotas privada à sub-rede privada
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

# Criação de um grupo de sub-redes para o banco de dados
resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  tags = {
    Name = "Main DB Subnet Group"
  }
}

# Definição da política de segurança para a sub-rede privada
resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.main.id

  # Permitir todo o tráfego de entrada TCP
  ingress {
    from_port   = 0
    to_port     = 65535 # Portas TCP variam de 0 a 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir tráfego de saída para a Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Definição da política de segurança para a sub-rede pública
resource "aws_security_group" "rds_public_sg" {
  name        = "rds_public_sg"
  description = "Allow postgres inbound traffic"
  vpc_id      = aws_vpc.main.id

  # Permitir tráfego de entrada apenas nas portas necessárias
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criação do grupo de segurança para o endpoint do SSM
resource "aws_security_group" "ssm_endpoint_sg" {
  name   = "ssm_endpoint_sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite tráfego de entrada de qualquer lugar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Permite todo o tráfego de saída para qualquer lugar
  }
}

# Criação do VPC endpoint para o AWS Systems Manager (SSM)
resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  subnet_ids         = [aws_subnet.private_subnet.id]

  tags = {
    Name = "SSM Endpoint"
  }
}
