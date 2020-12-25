variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "top_private_domain" {
  description = "Top UI hosting bucket (e.g., dev.example.com)"
}

variable "auth_subdomain" {
  description = "Subdomain for Cognito Hosted Authentication"
  default     = "auth"
}

variable "user_pool_name" {
  description = "name of user pool."
  default     = "user-pool"
}

variable "auth_logout_callback_path" {
  default = "/logout/callback"
}

variable "auth_login_callback_path" {
  default = "/login/callback"
}

variable "wildcard_certificate_arn" {
  description = "wildcard certificate value"
}

variable "route53_zone_id" {
  description = "zone id of the hosted route53"
}

variable "google_client_id" {
  description = "google CLIENT_ID needed to create social-login with google."
  default     = ""
}

variable "google_client_secret" {
  description = "google CLIENT_SECRET needed to create social-login with google."
  default     = ""
  sensitive   = true
}

variable "facebook_app_id" {
  description = "facebook app id needed to create social-login with facebook."
  default     = ""
}

variable "facebook_app_secret" {
  description = "facebook app secret needed to create social-login with facebook."
  default     = ""
  sensitive   = true
}

variable "facebook_api_version" {
  description = "which facebook api version to use. currently cognito supports 6.0"
  default     = "6.0"
  type        = string
}

variable "enable_facebook_idp" {
  description = "Set it to true if you want to enable login with facebook identity provider."
  type        = bool
  default     = false
}

variable "enable_google_idp" {
  description = "Set it to true if you want to enable login with google identity provider."
  type        = bool
  default     = false
}

variable "cognito_verification_message_template" {
  type    = map(string)
  default = {}
}

variable "cognito_default_email_option" {
  default = "CONFIRM_WITH_LINK"
}

variable "cognito_email_subject_by_link" {
  default = "Please Confirm Your Email Address."
}

variable "cognito_email_message_by_link" {
  default = "To confirm your email address please {##Click Here##}."
}

variable "should_create_root_domain_A_record" {
  type = bool
}
