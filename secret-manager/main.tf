provider "aws" {
  region = "ap-south-1"
}

#Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-sg"
  description = "Allow inbound traffic to RDS"

  ingress {
    from_port   = 5432 
    to_port     = 5432 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#DB_Credentials
resource "aws_secretsmanager_secret" "db_secret" {
  name        = "rds-db-credentials"
  description = "Credentials for RDS Database"
}

#Secret_Value
resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "dbadmin"
    password = "SuperSecurePassword123"
  })
}

#RDS_Instance
resource "aws_db_instance" "rds" {
  identifier             = "my-rds-db"
  allocated_storage      = 20
  engine                = "postgres"  
  engine_version        = "17.1"      
  instance_class        = "db.t3.micro"
  username             = jsondecode(aws_secretsmanager_secret_version.db_secret_version.secret_string)["username"]
  password             = jsondecode(aws_secretsmanager_secret_version.db_secret_version.secret_string)["password"]
  publicly_accessible  = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

#IAM_Policy
resource "aws_iam_policy" "secrets_access" {
  name        = "SecretsManagerAccess"
  description = "Allows access to RDS credentials stored in Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["secretsmanager:GetSecretValue"],
        Resource = aws_secretsmanager_secret.db_secret.arn
      }
    ]
  })
}

