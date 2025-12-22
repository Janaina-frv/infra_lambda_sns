resource "aws_lambda_function" "hello_lambda" {
  function_name = "HelloWorldLambda"
  role          = data.aws_iam_role.lambda_exec_role.arn
  handler       = "com.example.HelloWorldHandler"
  runtime       = "java11"

  filename      = "${path.module}/build/lambda/hello-lambda.jar"

  memory_size = 512
  timeout     = 10

  environment {
    variables = {
      SNS_TOPIC_ARN = "arn:aws:sqs:us-east-1:757367947438:feedback_urgente-sqs"
    }
  }
}
