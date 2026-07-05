resource "aws_scheduler_schedule" "this" {

  name       = var.schedule_name
  group_name = "default"

  schedule_expression = var.schedule_expression

  flexible_time_window {
    mode = "OFF"
  }

  target {

    arn      = var.state_machine_arn
    role_arn = var.role_arn

    input = jsonencode({
      source = "eventbridge-scheduler"
      action = "start-reconciliation"
    })

  }

}