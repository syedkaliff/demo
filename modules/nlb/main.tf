resource "aws_lb" "nlb" {
  name               = "Alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids
  
}

resource "aws_lb_target_group" "nlb_target_group" {
  name     = "nlb-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
    depends_on = [aws_lb.nlb]
}

resource "tls_private_key" "alb_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "alb_cert" {
  private_key_pem = tls_private_key.alb_key.private_key_pem

  subject {
    common_name  = aws_lb.nlb.dns_name
    organization = "MyOrg"
  }

  validity_period_hours = 8760
  is_ca_certificate     = false

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth"
  ]
}
resource "aws_acm_certificate" "self_signed_cert" {
  private_key       = tls_private_key.alb_key.private_key_pem
  certificate_body  = tls_self_signed_cert.alb_cert.cert_pem
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}

resource "aws_lb_listener" "alb_listener1" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate.self_signed_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}

