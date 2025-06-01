resource "aws_lambda_function" "barber_lambda" {
  filename         = "barber.zip"
  function_name    = "barber"
  handler          = "index.handler"
  runtime          = "nodejs22.x"
  role             = aws_iam_role.lambda_role.arn
  source_code_hash = filebase64sha256("barber.zip")
  environment {
    variables = {
      API_URL = ""
    }
  }
}