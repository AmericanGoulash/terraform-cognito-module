output "ui_login_url" {
  value = format(
    "https://%s/login?response_type=%s&client_id=%s&redirect_uri=%s&scope=%s",
    local.auth_domain,
    "token",
    aws_cognito_user_pool_client.client.id,
    "https://${var.top_private_domain}${var.auth_login_callback_path}",
    join("+", aws_cognito_user_pool_client.client.allowed_oauth_scopes)
  )
}