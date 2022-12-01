# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

provider_data = {
  "id": "3099",
  "code": "fake_oauth_client_xf",
  "name": "Fake OAuth Bank with Client Keys",
  "mode": "oauth",
  "status": "active",
  "automatic_fetch": false,
  "interactive": true,
  "instruction": "When initiating payments make sure to use one of the following IBANs for the Debtor IBAN:\nDE84100110012612443333, DE85100110012612447777, DE97100110012612446785, GB33BUKB20201555555555\n",
  "refresh_timeout": 15,
  "customer_notified_on_sign_in": false,
  "home_url": "https://example.com",
  "login_url": "https://example.com",
  "logo_url": "https://d1uuj3mi6rzwpm.cloudfront.net/logos/providers/xf/placeholder_global.svg",
  "country_code": "XF",
  "created_at": "2018-04-12T14:30:29Z",
  "updated_at": "2022-11-28T12:37:59Z",
  "timezone": "UTC",
  "holder_info": [
    "emails",
    "names",
    "phone_numbers"
  ],
  "max_consent_days": 90,
  "identification_mode": "client",
  "max_interactive_delay": 540,
  "optional_interactivity": true,
  "max_fetch_interval": 90,
  "supported_fetch_scopes": [
    "accounts",
    "holder_info",
    "transactions"
  ],
  "supported_account_extra_fields": [
    "account_name",
    "account_number",
    "available_amount",
    "bban",
    "blocked_amount",
    "card_type",
    "client_name",
    "closing_balance",
    "credit_limit",
    "expiry_date",
    "iban",
    "next_payment_amount",
    "next_payment_date",
    "sort_code",
    "status",
    "swift"
  ],
  "supported_transaction_extra_fields": [
    "account_number",
    "additional",
    "closing_balance",
    "convert",
    "opening_balance",
    "original_amount",
    "original_currency_code",
    "payee",
    "payee_information",
    "payer",
    "payer_information",
    "posting_date",
    "transfer_account_name"
  ],
  "supported_account_natures": [
    "account",
    "checking",
    "credit_card",
    "savings"
  ],
  "supported_account_types": [
    "business",
    "personal"
  ],
  "regulated": true,
  "identification_codes": [],
  "bic_codes": [],
  "supported_iframe_embedding": true,
  "payment_templates": [
    "FPS",
    "SEPA",
    "SEPA_INSTANT",
    "SWIFT",
    "sepa_instant_payment",
    "sepa_instant_payment_with_account_select"
  ],
  "no_funds_rejection_supported": false,
  "custom_pendings": false,
  "custom_pendings_period": 0,
  "required_fields": [],
  "interactive_fields": [
    {
      "name": "captcha",
      "english_name": "Captcha",
      "localized_name": "Captcha",
      "nature": "text",
      "position": 2,
      "optional": false,
      "extra": {}
    },
    {
      "name": "accounts",
      "english_name": "Accounts",
      "localized_name": "Accounts",
      "nature": "dynamic_select",
      "position": 4,
      "optional": false,
      "extra": {
        "multiple": true
      }
    },
    {
      "name": "account_name",
      "english_name": "Account Identifier",
      "localized_name": "Account Identifier",
      "nature": "dynamic_select",
      "position": 3,
      "optional": false,
      "extra": {
        "multiple": false
      }
    },
    {
      "name": "confirmation_code",
      "english_name": "Confirmation code (123456)",
      "localized_name": "Confirmation code (123456)",
      "nature": "text",
      "position": 1,
      "optional": false,
      "extra": {}
    }
  ]
}

Provider.create(
  code: provider_data[:code],
  data: provider_data
)

p 'provider fake_oauth_client_xf created'
