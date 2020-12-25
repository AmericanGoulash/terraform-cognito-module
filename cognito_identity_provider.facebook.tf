resource "aws_cognito_identity_provider" "facebook_provider" {
  user_pool_id  = aws_cognito_user_pool.pool.id
  provider_name = "Facebook"
  provider_type = "Facebook"

  provider_details = {
    authorize_scopes              = join(" ", local.facebook_idp_scopes)
    client_id                     = var.facebook_app_id
    client_secret                 = var.facebook_app_secret
    attributes_url                = "https://graph.facebook.com/me?fields="
    attributes_url_add_attributes = "true"
    authorize_url                 = "https://www.facebook.com/v${var.facebook_api_version}/dialog/oauth"
    token_request_method          = "GET"
    token_url                     = "https://graph.facebook.com/v${var.facebook_api_version}/oauth/access_token"
  }

  attribute_mapping = {
    email    = "email"
    name     = "name"
    username = "id"
  }

  lifecycle {
    ignore_changes = [
      provider_details.attributes_url,
      provider_details.attributes_url_add_attributes,
      provider_details.authorize_url,
      provider_details.token_request_method,
      provider_details.token_url,
    ]
  }
}