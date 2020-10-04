data "aws_acm_certificate" "lb_cert" {
  domain   = "tech.sogyalsherpa.com"
  statuses = ["ISSUED"]
}

resource "aws_lb" "proxy_lb" {
  name               = "api-proxy-lb"
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group_api_lb]
  subnets            = var.aws_subnet_public_api_id

  enable_deletion_protection = true

  tags = merge(
    map(
      "Name", "api-proxy-lb"
    ),
    var.common_tags
  )
}

resource "aws_lb_listener" "api_lb_listener" {
  load_balancer_arn = aws_lb.proxy_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.lb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_lb_target_group.arn
  }
}

resource "aws_lb_target_group" "api_lb_target_group" {
  name              = "api-lb-proxy-tg"
  port              = 443
  protocol          = "TCP"
  target_type       = "ip"
  vpc_id            = var.vpc_id
  proxy_protocol_v2 = "true"

	tags = merge(
		var.common_tags,
		map(
			"Name", "api-lb-proxy-tg"
		)
  )
}