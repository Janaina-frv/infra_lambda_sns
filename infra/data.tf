data "aws_iam_role" "lambda_exec_role" {
  name = "lambda-java-exec-role-manual"
}

data "aws_sns_topic" "feedback_urgente" {
  name = "feedback_urgente-sns"
}
