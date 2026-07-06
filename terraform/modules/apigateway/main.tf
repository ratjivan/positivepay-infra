resource "aws_apigatewayv2_api" "http_api" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "generate_reports" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.generate_reports_lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "generate_reports" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /generate-report"
  target    = "integrations/${aws_apigatewayv2_integration.generate_reports.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "allow_apigw_generate" {
  statement_id  = "AllowAPIGatewayGenerate"
  action        = "lambda:InvokeFunction"
  function_name = var.generate_reports_lambda_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
