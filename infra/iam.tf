resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-sns-publish-policy"
  description = "Permite Lambda publicar mensagens no SNS"
  policy      = file("${path.module}/policy/lambda.json")
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = data.aws_iam_role.lambda_exec_role.id
  policy_arn = aws_iam_policy.lambda_policy.arn
}
