#  Intent for ordering food
resource "aws_lex_intent" "order_food" {
  name        = "OrderFood"
  description = "Intent to order food for delivery"

  sample_utterances = [
    "I want to order {FoodType}",
    "Please deliver {FoodType}",
    "Can I get {Quantity} {FoodType}"
  ]

  # Fulfillment: simple return message
  fulfillment_activity {
    type = "ReturnIntent"
  }

  # Rejection statement
  rejection_statement {
    message {
      content      = "Okay, I won’t place the order."
      content_type = "PlainText"
    }
  }
  # Slots
  slot {
    name              = "FoodType"
    description       = "Type of food to order"
    priority          = 1
    slot_constraint   = "Required"
    slot_type         = "AMAZON.Food"
    slot_type_version = "$LATEST"

    value_elicitation_prompt {
      max_attempts = 2
      message {
        content      = "What food would you like to order? (e.g., pizza, burger)"
        content_type = "PlainText"
      }
    }
  }

  slot {
    name              = "Quantity"
    description       = "Number of items"
    priority          = 2
    slot_constraint   = "Required"
    slot_type         = "AMAZON.Number"
    slot_type_version = "$LATEST"

    value_elicitation_prompt {
      max_attempts = 2
      message {
        content      = "How many portions would you like?"
        content_type = "PlainText"
      }
    }
  }

  slot {
    name              = "DeliveryAddress"
    description       = "Delivery address"
    priority          = 3
    slot_constraint   = "Required"
    slot_type         = "AMAZON.Address"
    slot_type_version = "$LATEST"

    value_elicitation_prompt {
      max_attempts = 2
      message {
        content      = "Where should we deliver your order?"
        content_type = "PlainText"
      }
    }
  }

  confirmation_prompt {
    max_attempts = 2
    message {
      content      = "You want {Quantity} {FoodType} delivered to {DeliveryAddress}, right?"
      content_type = "PlainText"
    }
  }

  conclusion_statement {
    message {
      content      = "Great! Your Getko Food order has been placed!"
      content_type = "PlainText"
    }
  }
}

#Bot definition
resource "aws_lex_bot" "getko_food_bot" {
  name           = "GetkoFoodBot"
  locale         = "en-US"
  child_directed = false

  abort_statement {
    message {
      content      = "Sorry, I am not able to assist at this time"
      content_type = "PlainText"
    }
  }
  intent {
    intent_name    = aws_lex_intent.order_food.name
    intent_version = "$LATEST"
  }
}
