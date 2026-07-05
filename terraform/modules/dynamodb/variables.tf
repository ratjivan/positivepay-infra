variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "billing_mode" {
  description = "PAY_PER_REQUEST or PROVISIONED"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Primary partition key"
  type        = string
  default     = "id"
}

variable "enable_pitr" {
  description = "Enable point-in-time recovery"
  type        = bool
  default     = true
}