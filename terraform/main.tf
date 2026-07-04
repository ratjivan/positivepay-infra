resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_poli = json({
    Version = 
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}