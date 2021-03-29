resource "aws_cognito_identity_provider" "facebook_provider" {
  count         = var.enable_facebook_idp ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.pool.id
  provider_name = "Facebook"
  provider_type = "Facebook"

  provider_details = {
    authorize_scopes              = join(", ", local.facebook_idp_scopes)
    client_id                     = var.facebook_app_id
    client_secret                 = var.facebook_app_secret
    api_version                   = var.facebook_api_version
    attributes_url_add_attributes = true
  }

  attribute_mapping = {
    email   = "email"
    profile = "public_profile"
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