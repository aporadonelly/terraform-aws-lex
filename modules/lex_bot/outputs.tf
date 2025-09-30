output "bot_name" {
  value = aws_lex_bot.getko_food_bot.name
}

output "bot_arn" {
  value = aws_lex_bot.getko_food_bot.arn
}

output "intent_name" {
  value = aws_lex_intent.order_food.name
}
