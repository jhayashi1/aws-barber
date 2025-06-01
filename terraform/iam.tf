resource "aws_iam_role" "lambda_role" {
  name = "barber-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "barber-policy"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "events:PutEvents",
            "scheduler:CreateSchedule",
            "scheduler:UpdateSchedule",
            "scheduler:DeleteSchedule",
            "scheduler:GetSchedule",
            "scheduler:ListSchedules",
            "sns:Publish"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}