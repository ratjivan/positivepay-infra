output "lambda_role_arn" {
  value = module.iam.lambda_role_arn
}

output "step_function_role_arn" {
  value = module.iam.step_function_role_arn
}

output "scheduler_role_arn" {
  value = module.iam.scheduler_role_arn
}

output "s3_bucket_name" {
  value = module.reports_bucket.bucket_name
}

output "s3_bucket_arn" {
  value = module.reports_bucket.bucket_arn
}

output "sqs_queue_url" {
  value = module.reconciliation_queue.queue_url
}

output "sqs_queue_arn" {
  value = module.reconciliation_queue.queue_arn
}

output "sqs_dlq_arn" {
  value = module.reconciliation_queue.dlq_arn
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb.table_arn
}

output "generate_reports_lambda_arn" {
  value = module.generate_reports_lambda.lambda_arn
}

output "fetch_reports_lambda_arn" {
  value = module.fetch_reports_lambda.lambda_arn
}

output "notification_lambda_arn" {
  value = module.notification_lambda.lambda_arn
}

output "step_function_arn" {
  value = module.step_function.state_machine_arn
}

output "scheduler_name" {
  value = module.eventbridge_scheduler.schedule_name
}

output "alarm_sns_topic_arn" {
  value = module.cloudwatch.sns_topic_arn
}

output "generate_reports_lambda_url" {
  value = module.generate_reports_lambda.lambda_url
}

output "api_url" {
  value = module.api_gateway.api_endpoint
}
output "api_endpoint" {
  value = module.api_gateway.api_endpoint
}

output "frontend_bucket_name" {
  value = module.frontend_bucket.bucket_name
}

output "cloudfront_url" {

  value = module.cloudfront.cloudfront_domain_name

}