data "aws_iam_policy_document" "lambda_assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "lambda.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}

resource "aws_iam_role" "lambda_role" {

  name = "${var.environment}-lambda-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

}

resource "aws_iam_role_policy_attachment" "lambda_logs" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

data "aws_iam_policy_document" "step_function_assume" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "states.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}

resource "aws_iam_role" "step_function_role" {

  name = "${var.environment}-step-function-role"

  assume_role_policy = data.aws_iam_policy_document.step_function_assume.json

}

data "aws_iam_policy_document" "scheduler_assume" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "scheduler.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}

resource "aws_iam_role" "scheduler_role" {

  name = "${var.environment}-scheduler-role"

  assume_role_policy = data.aws_iam_policy_document.scheduler_assume.json

}

