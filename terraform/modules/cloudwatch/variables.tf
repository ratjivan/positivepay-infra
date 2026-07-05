variable "lambda_functions" {
  description = "List of lambda function names"
  type        = list(string)
}

variable "environment" {
  type = string
}

variable "alarm_email" {
  type        = string
  description = "Email for alarm notifications"
}