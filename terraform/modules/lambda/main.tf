resource "aws_lambda_function" "this" {

  function_name = var.function_name

  role          = var.role_arn

  handler       = var.handler

  runtime       = var.runtime

  timeout       = var.timeout

  memory_size   = var.memory_size

  filename         = "${path.module}/sample.zip"
  source_code_hash = filebase64sha256("${path.module}/sample.zip")

  environment {

    variables = var.environment_variables

  }

}

resource "aws_cloudwatch_log_group" "logs" {

  name              = "/aws/lambda/${var.function_name}"

  retention_in_days = 14

}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {

  count = var.enable_sqs ? 1 : 0

  event_source_arn = var.sqs_arn
  function_name    = aws_lambda_function.this.arn

  batch_size = 10
  enabled    = true
}

