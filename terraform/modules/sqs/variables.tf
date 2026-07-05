variable "queue_name" {
  description = "Main Queue Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "max_receive_count" {
  description = "Maximum retries before moving to DLQ"
  type        = number
  default     = 5
}

variable "visibility_timeout" {
  description = "Visibility timeout"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "Message retention period"
  type        = number
  default     = 345600
}