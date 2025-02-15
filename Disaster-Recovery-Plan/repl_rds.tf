resource "aws_db_instance" "primary_rds" {
  provider              = aws.primary
  identifier           = "primary-db"
  allocated_storage    = 20
  instance_class       = "db.t3.micro"
  engine              = "mysql"
  engine_version      = "8.0"
  username            = "dbadmin"
  password            = "SecurePass123"
  publicly_accessible = false
  backup_retention_period = 7
  skip_final_snapshot = true
}


resource "aws_db_instance" "read_replica" {
  provider             = aws.dr
  identifier          = "dr-db"
  replicate_source_db = aws_db_instance.primary_rds.arn
  instance_class      = "db.t3.micro"
  publicly_accessible = false
  backup_retention_period = 7
  skip_final_snapshot = true
}
