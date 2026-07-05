output "queue_name" {

  value = aws_sqs_queue.main_queue.name

}

output "queue_url" {

  value = aws_sqs_queue.main_queue.id

}

output "queue_arn" {

  value = aws_sqs_queue.main_queue.arn

}

output "dlq_name" {

  value = aws_sqs_queue.dlq.name

}

output "dlq_arn" {

  value = aws_sqs_queue.dlq.arn

}