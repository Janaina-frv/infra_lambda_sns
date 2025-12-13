variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}
variable "sns_topic_exists" {
  type    = bool
  default = true  # ou false se não existir
}