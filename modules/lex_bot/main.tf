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

# Attach AmazonLexFullAccess
resource "aws_iam_role_policy_attachment" "lex_full_access" {
  role       = aws_iam_role.lex_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonLexFullAccess"
}

# Attach CloudWatch logging
resource "aws_iam_role_policy_attachment" "cw_logs_access" {
  role       = aws_iam_role.lex_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# Locale (English)
resource "aws_lexv2models_bot_locale" "en_us" {
  bot_id      = aws_lexv2models_bot.getko_food_bot.id
  bot_version = "DRAFT"
  locale_id   = "en_US"

  n_lu_intent_confidence_threshold = 0.70
}

# Intent (OrderFood)
resource "aws_lexv2models_intent" "order_food" {
  bot_id      = aws_lexv2models_bot.getko_food_bot.id
  bot_version = aws_lexv2models_bot_locale.en_us.bot_version
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "OrderFood"

  sample_utterance {
    utterance = "I want to order {FoodType}"
  }
  sample_utterance {
    utterance = "Please deliver {FoodType}"
  }
  sample_utterance {
    utterance = "Can I get {Quantity} {FoodType}"
  }

  fulfillment_code_hook {
    enabled = false
  }
}
