# Bot name
output "lex_bot_name" {
  value = module.lex_bot.bot_name
}

# Intent name
output "lex_intent_name" {
  value = module.lex_bot.intent_name
}

# Bot ARN
output "lex_bot_arn" {
  value = module.lex_bot.bot_arn
}
