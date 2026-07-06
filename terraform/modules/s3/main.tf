resource "aws_s3_bucket" "bucket" {

  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }

}

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

  bucket = aws_s3_bucket.bucket.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

resource "aws_s3_bucket_public_access_block" "public_access" {

  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true

  block_public_policy     = true

  ignore_public_acls      = true

  restrict_public_buckets = true

}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {

  bucket = aws_s3_bucket.bucket.id

  rule {

    id = "cleanup"

    status = "Enabled"

    filter {}

    noncurrent_version_expiration {

      noncurrent_days = 90

    }

  }

}

resource "aws_s3_bucket" "logs" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_lifecycle_configuration" "logs_lifecycle" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "delete-after-2-days"
    status = "Enabled"

    expiration {
      days = 2
    }
  }
}