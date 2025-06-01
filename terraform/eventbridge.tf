resource "aws_cloudwatch_event_rule" "barber_event_rule" {
  name        = "barber-event-rule"
  description = "Trigger barber lambda on matching events"
  event_pattern = jsonencode({
    "source": ["barber.scheduled.trigger"]
  })
}

resource "aws_cloudwatch_event_target" "barber_event_target" {
  rule      = aws_cloudwatch_event_rule.barber_event_rule.name
  target_id = "barber-lambda"
  arn       = aws_lambda_function.barber_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge_invoke" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.barber_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.barber_event_rule.arn
}