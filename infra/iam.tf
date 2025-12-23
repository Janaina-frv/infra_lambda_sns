resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-sns-publish-policy"
  description = "Permite Lambda publicar mensagens no SNS"
  policy      = file("${path.module}/policy/lambda.json")
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = "lambda-java-exec-role-manual"
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-java-exec-role-manual"

  description = "IAM Role para execução de funções Lambda em Java com permissão de publicar no SNS"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}