resource "aws_backup_plan" "dr_plan" {
  name = "dr-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.dr_vault.name
    schedule          = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 30  # Retain backups for 30 days
    }
  }
}

resource "aws_backup_vault" "dr_vault" {
  name = "dr-backup-vault"
}


resource "aws_backup_selection" "select" {
  iam_role_arn      = aws_iam_role.backup_role.arn
  name              = "dr-backup-selection"
  plan_id           = aws_backup_plan.dr_plan.id

  resources = [
    aws_db_instance.primary_rds.arn  # Backing up the primary RDS
  ]
}

resource "aws_iam_role" "backup_role" {
  name = "AWSBackupRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_role_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

