resource "aws_sqs_queue" "dlq" {

  name = "${var.queue_name}-dlq"

  message_retention_seconds = var.message_retention_seconds

  tags = {
    Environment = var.environment
  }

}


resource "aws_sqs_queue" "main_queue" {

  name = var.queue_name

  visibility_timeout_seconds = var.visibility_timeout

  message_retention_seconds = var.message_retention_seconds

  redrive_policy = jsonencode({

    deadLetterTargetArn = aws_sqs_queue.dlq.arn

    maxReceiveCount = var.max_receive_count

  })

  tags = {

    Environment = var.environment

  }

}

resource "aws_sqs_queue_policy" "queue_policy" {

  queue_url = aws_sqs_queue.main_queue.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Sid = "AllowAll"

        Effect = "Allow"

        Principal = "*"

        Action = "SQS:*"

        Resource = aws_sqs_queue.main_queue.arn

      }

    ]

  })

}

