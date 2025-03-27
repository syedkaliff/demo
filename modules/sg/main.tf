resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  for_each                 = var.ingress_rules
  security_group_id        = aws_security_group.main.id
  description              = lookup(each.value, "description", null)
  type                     = "ingress"
  from_port                = lookup(each.value, "from_port", null)
  to_port                  = lookup(each.value, "to_port", null)
  protocol                 = lookup(each.value, "protocol", null)
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_sg_id", null)
  self                     = lookup(each.value, "self", null)
}

resource "aws_security_group_rule" "egress" {
  for_each                 = var.egress_rules
  security_group_id        = aws_security_group.main.id
  description              = lookup(each.value, "description", null)
  type                     = "egress"
  from_port                = lookup(each.value, "from_port", null)
  to_port                  = lookup(each.value, "to_port", null)
  protocol                 = lookup(each.value, "protocol", null)
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_sg_id", null)
  self                     = lookup(each.value, "self", null)
}
