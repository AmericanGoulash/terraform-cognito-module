resource "aws_cognito_user_pool" "pool" {
  name                = var.user_pool_name
  username_attributes = ["email", "phone_number"]
  username_configuration {
    case_sensitive = false
  }
  auto_verified_attributes = [
    "email"
  ]
  verification_message_template {
    default_email_option  = var.cognito_default_email_option
    email_subject_by_link = var.cognito_email_subject_by_link
    email_message_by_link = var.cognito_email_message_by_link
  }

  # These attributes are required for user signup.
  # To use standard attributes (https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#cognito-user-pools-standard-attributes),
  # we can just specify the name here.
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  tags = merge(local.common_tags, var.common_tags, { Name = "cognito_user_pool" })
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.user_pool_name}-client"
  user_pool_id = aws_cognito_user_pool.pool.id

  callback_urls = [
    local.login_callback_url
  ]
  logout_urls = [
    local.logout_callback_url
  ]
  allowed_oauth_flows = [
    "implicit",
    "code"
  ]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = concat(local.cognito_idp_scopes, local.oath_idp_scopes)

  supported_identity_providers = tolist([
    var.enable_google_idp ? aws_cognito_identity_provider.google.provider_name : "COGNITO",
    var.enable_facebook_idp ? aws_cognito_identity_provider.facebook_provider[count.index].provider_name : "COGNITO",
    "COGNITO"
  ])
}
