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
      SNS_TOPIC_ARN = var.tf_action == "apply" && length(var.sns_arn) > 0 ? var.sns_arn : ""
    }
  }
}
