resource "aws_db_instance" "dr_restore" {
  identifier          = "restored-dr-db"
  snapshot_identifier = "arn:aws:rds:us-west-2:123456789012:snapshot:backup-snapshot"
  instance_class      = "db.t3.micro"
  publicly_accessible = false
}

