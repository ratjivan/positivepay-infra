resource "aws_dynamodb_table" "table" {

  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  # ✅ ENABLE POINT IN TIME RECOVERY (CORRECT WAY)
  point_in_time_recovery {
    enabled = true
  }

  # ✅ SERVER SIDE ENCRYPTION (CORRECT WAY)
  server_side_encryption {
    enabled = true
  }

  tags = {
    Environment = var.environment
  }
}