variable "function_name" {
  type        = string
  description = "Lambda function name"
}

variable "handler" {
  type        = string
  description = "Lambda handler (index.handler)"
}

variable "enable_sqs" {
  type    = bool
  default = false
}

variable "sqs_arn" {
  type    = string
  default = null
}

variable "runtime" {
  type        = string
  default     = "nodejs18.x"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for Lambda execution"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
}

variable "timeout" {
  type        = number
  default     = 30
}

variable "memory_size" {
  type        = number
  default     = 128
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket where lambda zip is stored"
}

variable "s3_key" {
  type        = string
  description = "S3 key of lambda zip"
}