data "aws_iam_role" "lambda_exec_role" {
  name = "lambda-java-exec-role-manual"
}

data "aws_sns_topic" "feedback_urgente" {
  count = var.sns_topic_exists ? 1 : 0
  name  = "feedback_urgente-sns"
}
