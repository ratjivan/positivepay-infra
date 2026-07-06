module "iam" {
  source      = "../../modules/iam"
  environment = "dev"
}

module "reports_bucket" {

  source = "../../modules/s3"

  bucket_name = "account-reconciliation-dev-reports"

  environment = "dev"

}

module "uploads_bucket" {
  source      = "../../modules/s3"
  bucket_name = "account-reconciliation-dev-uploads"
  environment = "dev"
}

module "reconciliation_queue" {

  source = "../../modules/sqs"

  queue_name = "account-reconciliation-dev"

  environment = "dev"

}

module "dynamodb" {

  source = "../../modules/dynamodb"

  table_name = "account-reconciliation-dev"

  environment = "dev"

  hash_key = "id"

  enable_pitr = true

}


module "generate_reports_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-generate-reports"

  handler = "index.handler"

  runtime = "nodejs18.x"

  role_arn = module.iam.lambda_role_arn

  s3_bucket = "lambda-code-bucket"

  s3_key = "generate-reports.zip"

  environment_variables = {
    ENV = "dev"
  }
}

module "fetch_reports_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-fetch-reports"

  handler = "index.handler"

  runtime = "nodejs18.x"

  role_arn = module.iam.lambda_role_arn

  s3_bucket = "lambda-code-bucket"

  s3_key = "fetch-reports.zip"

  environment_variables = {
    ENV = "dev"
  }
}

module "file_transmission_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-file-transmission"

  handler = "index.handler"

  role_arn = module.iam.lambda_role_arn

  s3_bucket = "lambda-code-bucket"

  s3_key = "file-transmission.zip"

  environment_variables = {
    ENV = "dev"
  }
}

module "reconciliation_worker_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-reconciliation-worker"

  role_arn = module.iam.lambda_role_arn

  sqs_arn    = module.reconciliation_queue.queue_arn
  enable_sqs = true
  handler    = "index.handler"
  s3_bucket  = module.reports_bucket.bucket_name
  s3_key     = "notification.zip"
}

module "deposit_worker_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-deposit-worker"

  handler = "index.handler"

  role_arn = module.iam.lambda_role_arn

  s3_bucket = "lambda-code-bucket"

  s3_key = "deposit-worker.zip"

  environment_variables = {
    ENV = "dev"
  }
}

module "account_worker_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-account-worker"

  handler = "index.handler"

  role_arn = module.iam.lambda_role_arn

  s3_bucket = "lambda-code-bucket"

  s3_key = "account-worker.zip"

  environment_variables = {
    ENV = "dev"
  }
}

module "notification_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-notification"
  handler       = "index.handler"
  s3_bucket     = module.reports_bucket.bucket_name
  s3_key        = "notification.zip"

  role_arn = module.iam.lambda_role_arn

  enable_sqs = false
}

module "scheduled_trigger_lambda" {
  source = "../../modules/lambda"

  function_name = "dev-scheduled-trigger"

  handler = "index.handler"

  role_arn = module.iam.lambda_role_arn

  s3_bucket = "lambda-code-bucket"

  s3_key = "scheduled-trigger.zip"

  environment_variables = {
    ENV = "dev"
  }
}

module "step_function" {
  source = "../../modules/step_function"

  state_machine_name = "dev-reconciliation-workflow"

  role_arn = module.iam.step_function_role_arn

  generate_report_lambda_arn = module.generate_reports_lambda.lambda_arn

  reconciliation_worker_lambda_arn = module.reconciliation_worker_lambda.lambda_arn

  deposit_worker_lambda_arn = module.deposit_worker_lambda.lambda_arn

  account_worker_lambda_arn = module.account_worker_lambda.lambda_arn

  notification_lambda_arn = module.notification_lambda.lambda_arn
}

module "eventbridge_scheduler" {

  source = "../../modules/eventbridge"

  schedule_name = "dev-reconciliation-schedule"

  schedule_expression = "rate(5 minutes)"

  role_arn = module.iam.scheduler_role_arn

  state_machine_arn = module.step_function.state_machine_arn
}

module "cloudwatch" {

  source = "../../modules/cloudwatch"

  environment = "dev"

  alarm_email = "your-email@example.com"

  lambda_functions = [
    module.generate_reports_lambda.lambda_name,
    module.fetch_reports_lambda.lambda_name,
    module.file_transmission_lambda.lambda_name,
    module.reconciliation_worker_lambda.lambda_name,
    module.deposit_worker_lambda.lambda_name,
    module.account_worker_lambda.lambda_name,
    module.notification_lambda.lambda_name,
    module.scheduled_trigger_lambda.lambda_name
  ]
}

module "api_gateway" {
  source = "../../modules/apigateway"

  api_name = "account-reconciliation-dev-api"

  generate_reports_lambda_invoke_arn = module.generate_reports_lambda.lambda_invoke_arn
  generate_reports_lambda_name       = module.generate_reports_lambda.lambda_name
}

module "frontend_bucket" {
  source = "../../modules/s3_frontend"

  bucket_name = "account-reconciliation-dev-frontend"
  environment = "dev"
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  bucket_name                 = module.frontend_bucket.bucket_name
  bucket_arn                  = module.frontend_bucket.bucket_arn
  bucket_regional_domain_name = module.frontend_bucket.bucket_regional_domain_name
}