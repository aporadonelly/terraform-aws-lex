# Lex V2 Bot
resource "aws_lexv2models_bot" "getko_food_bot" {
  name     = "${var.project_prefix}-food-bot"
  role_arn = aws_iam_role.lex_service_role.arn
  type     = "Bot"

  data_privacy {
    child_directed = false
  }

  idle_session_ttl_in_seconds = 300

}

resource "aws_iam_role" "lex_service_role" {
  name = "${var.project_prefix}-lex-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lexv2.amazonaws.com"
        }
      },
    ]
  })
}
