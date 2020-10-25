resource "aws_cognito_identity_provider" "google" {
  user_pool_id  = aws_cognito_user_pool.pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields=coverPhotos,photos"
    attributes_url_add_attributes = "true"
    authorize_scopes              = "profile email openid"
    authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
    token_request_method          = "POST"
    token_url                     = "https://www.googleapis.com/oauth2/v4/token"
    client_id                     = var.google_client_id
    client_secret                 = var.google_client_secret
    oidc_issuer                   = "https://accounts.google.com"
  }

  attribute_mapping = {
    username = "sub"
    email    = "email"
    name     = "name"
    picture  = "picture"
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