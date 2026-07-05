resource "aws_dynamodb_table" "table" {

  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = {
    Environment = var.environment
  }

}

resource "aws_dynamodb_table_point_in_time_recovery" "pitr" {

  count = var.enable_pitr ? 1 : 0

  table_name = aws_dynamodb_table.table.name

}

resource "aws_dynamodb_table_server_side_encryption" "encryption" {

  table_name = aws_dynamodb_table.table.name

  enabled    = true

}

