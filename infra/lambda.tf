resource "aws_lambda_function" "hello_lambda" {
  function_name = "HelloWorldLambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "com.example.HelloWorldHandler"
  runtime       = "java11"

  filename      = "${path.module}/build/lambda/hello-lambda.jar"

  memory_size = 512
  timeout     = 10

  environment {
    variables = {
      SNS_TOPIC_ARN = "arn:aws:sns:us-east-1:757367947438:feedback_urgente-sns"
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn  = aws_sqs_queue.my_queue.arn
  function_name     = aws_lambda_function.hello_lambda.arn
  batch_size        = 10  # quantas mensagens a Lambda recebe por vez
  enabled           = true
}
