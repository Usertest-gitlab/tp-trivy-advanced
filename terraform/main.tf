# Terraform avec misconfigurations intentionnelles pour le TP

# S3 bucket sans chiffrement (misconfiguration)
resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"  # Mauvaise pratique : bucket public
}

# Pas de chiffrement configuré (manquant)
# resource "aws_s3_bucket_server_side_encryption_configuration" "..."

# Security Group trop permissif
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Ouvert au monde entier
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instance EC2 sans monitoring
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  # Pas de chiffrement du disque
  # Pas de monitoring activé
  # Pas de metadata service v2
}

# RDS sans chiffrement
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "password123"  # Mot de passe en clair !
  storage_encrypted    = false          # Pas de chiffrement
  publicly_accessible  = true           # Accessible publiquement
}
