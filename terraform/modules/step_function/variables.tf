variable "state_machine_name" {
  type        = string
  description = "Name of Step Function"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for Step Function"
}

variable "generate_report_lambda_arn" {
  type = string
}

variable "reconciliation_worker_lambda_arn" {
  type = string
}

variable "deposit_worker_lambda_arn" {
  type = string
}

variable "account_worker_lambda_arn" {
  type = string
}

variable "notification_lambda_arn" {
  type = string
}