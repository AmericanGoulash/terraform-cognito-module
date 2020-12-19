resource "aws_cognito_identity_provider" "facebook_provider_production" {
  user_pool_id  = aws_cognito_user_pool.pool.id
  provider_name = "Facebook"
  provider_type = "Facebook"

  provider_details = {
    authorize_scopes              = "email"
    client_id                     = var.facebook_app_id
    client_secret                 = var.facebook_app_secret
    attributes_url                = "https://graph.facebook.com/me?fields="
    attributes_url_add_attributes = "true"
    authorize_url                 = "https://www.facebook.com/v2.9/dialog/oauth"
    token_request_method          = "GET"
    token_url                     = "https://graph.facebook.com/v2.9/oauth/access_token"
  }

  attribute_mapping = {
    email    = "email"
    name     = "name"
    username = "id"
  }
}