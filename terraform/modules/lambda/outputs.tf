output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_name" {
  value = aws_lambda_function.this.function_name
}

output "lambda_url" {
  value = aws_lambda_function_url.this.function_url
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}