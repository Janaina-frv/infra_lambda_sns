variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}
variable "sns_topic_exists" {
  type    = bool
  default = false
}

variable "tf_action" {
  type    = string
  description = "Ação do Terraform, ex: apply ou destroy"
  default = "apply"
}

variable "sns_arn" {
  type        = string
  description = "ARN do tópico SNS"
  default     = ""
}
