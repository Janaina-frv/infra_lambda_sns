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
      SNS_TOPIC_ARN = var.sns_topic_exists ? try(data.aws_sns_topic.feedback_urgente[0].arn, "") : ""
    }
  }
}
