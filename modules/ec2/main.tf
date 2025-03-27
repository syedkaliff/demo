resource "aws_instance" "main" {
  ami             = "ami-071226ecf16aa7d96"  
  instance_type   = "t2.small"
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  key_name = "t1"
}

resource "aws_lb_target_group_attachment" "alb_attachment" {
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_instance.main.id
  port            = 80
}

resource "aws_lb_target_group_attachment" "alb_attachment1" {
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_instance.main.id
  port            = 443
}
