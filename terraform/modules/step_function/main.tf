resource "aws_sfn_state_machine" "this" {

  name     = var.state_machine_name
  role_arn = var.role_arn

  definition = jsonencode({

    Comment = "Account Reconciliation Workflow"

    StartAt = "GenerateReport"

    States = {

      GenerateReport = {
        Type = "Task"
        Resource = var.generate_report_lambda_arn

        Next = "ParallelWorkers"

        Retry = [{
          ErrorEquals = ["States.ALL"]
          IntervalSeconds = 2
          MaxAttempts = 3
        }]

      }

      ParallelWorkers = {
        Type = "Parallel"

        Branches = [

          {
            StartAt = "ReconciliationWorker"
            States = {
              ReconciliationWorker = {
                Type = "Task"
                Resource = var.reconciliation_worker_lambda_arn
                End = true
              }
            }
          },

          {
            StartAt = "DepositWorker"
            States = {
              DepositWorker = {
                Type = "Task"
                Resource = var.deposit_worker_lambda_arn
                End = true
              }
            }
          },

          {
            StartAt = "AccountWorker"
            States = {
              AccountWorker = {
                Type = "Task"
                Resource = var.account_worker_lambda_arn
                End = true
              }
            }
          }

        ]

        Next = "Notify"
      }

      Notify = {
        Type = "Task"
        Resource = var.notification_lambda_arn
        End = true
      }

    }

  })

}