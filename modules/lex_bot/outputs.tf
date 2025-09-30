output "bot_name" {
  value = aws_lexv2models_bot.getko_food_bot.name
}

output "bot_id" {
  value = aws_lexv2models_bot.getko_food_bot.id
}

output "bot_arn" {
  value = aws_lexv2models_bot.getko_food_bot.arn
}

output "locale_id" {
  value = aws_lexv2models_bot_locale.en_us.locale_id
}

output "intent_name" {
  value = aws_lexv2models_intent.order_food.name
}
