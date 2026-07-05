variable "schedule_name" {
  type        = string
  description = "Scheduler name"
}

variable "schedule_expression" {
  type        = string
  description = "cron or rate expression"
}

variable "role_arn" {
  type        = string
  description = "IAM role for scheduler"
}

variable "state_machine_arn" {
  type        = string
  description = "Step Function ARN to trigger"
}