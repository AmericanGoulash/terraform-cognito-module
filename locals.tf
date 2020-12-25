locals {
  # It should always be this value.
  # See: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-aliastarget.html
  cloudfront_hosted_zone_id = "Z2FDTNDATAQYW2"

  auth_domain         = "${var.auth_subdomain}.${var.top_private_domain}"
  login_callback_url  = "https://${var.top_private_domain}${var.auth_login_callback_path}"
  logout_callback_url = "https://${var.top_private_domain}${var.auth_logout_callback_path}"

  common_tags = {
    CreatedBy = "terraform"
    Component = "cognito"
  }

  cognito_idp_scopes = [
    "aws.cognito.signin.user.admin"
  ]

  google_idp_scopes = [
    "profile",
    "email",
    "openid"
  ]

  facebook_idp_scopes = [
    "email",
    "name",
    "openid"
  ]
}
