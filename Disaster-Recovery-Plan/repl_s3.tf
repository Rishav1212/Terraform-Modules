resource "aws_s3_bucket" "primary" {
  provider = aws.primary
  bucket   = "my-primary-backup-bucket"
  force_destroy = true
}

resource "aws_s3_bucket" "dr" {
  provider = aws.dr
  bucket   = "my-dr-backup-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "primary" {
  provider = aws.primary
  bucket   = aws_s3_bucket.primary.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "dr" {
  provider = aws.dr
  bucket   = aws_s3_bucket.dr.id
  versioning_configuration {
    status = "Enabled"
  }
}

