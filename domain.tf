resource "aws_cognito_user_pool_domain" "domain" {
  user_pool_id    = aws_cognito_user_pool.pool.id
  domain          = local.auth_domain
  certificate_arn = var.wildcard_certificate_arn

  lifecycle {
    create_before_destroy = false
  }

  depends_on = [
    aws_route53_record.root_domain_A_record
  ]
}

resource "aws_route53_record" "cognito_domain_ipv4_record" {
  name    = aws_cognito_user_pool_domain.domain.domain
  zone_id = var.route53_zone_id
  type    = "A"

  alias {
    # This isn't actually an ARN; it's a domain name in the format "xxxxxxxx.cloudfront.net"
    name                   = aws_cognito_user_pool_domain.domain.cloudfront_distribution_arn
    zone_id                = local.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "cognito_domain_ipv6_record" {
  name    = aws_cognito_user_pool_domain.domain.domain
  zone_id = var.route53_zone_id
  type    = "AAAA"

  alias {
    # This isn't actually an ARN; it's a domain name in the format "xxxxxxxx.cloudfront.net"
    name                   = aws_cognito_user_pool_domain.domain.cloudfront_distribution_arn
    zone_id                = local.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "root_domain_A_record" {
  count   = var.should_create_root_domain_A_record ? 1 : 0
  zone_id = var.route53_zone_id
  name    = var.top_private_domain
  type    = "A"
  ttl     = 300
  records = ["127.0.0.1"] # Placeholder that is never used

  lifecycle {
    create_before_destroy = false
  }
}
