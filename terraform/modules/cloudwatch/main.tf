resource "aws_sns_topic" "alarm_topic" {

  name = "${var.environment}-lambda-alarms"

}

resource "aws_sns_topic_subscription" "email" {

  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol   = "email"
  endpoint   = var.alarm_email

}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {

  for_each = toset(var.lambda_functions)

  alarm_name          = "${each.value}-error-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    FunctionName = each.value
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]

}

