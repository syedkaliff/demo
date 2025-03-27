variable "vpc_id" {}

variable "ingress_rules" {
  type = map(object({
    from_port    = number
    to_port      = number
    protocol     = string
    description  = string
    cidr_blocks  = list(string)
    source_sg_id = string
    self         = bool
  }))
}

variable "egress_rules" {
  type = map(object({
    from_port    = number
    to_port      = number
    protocol     = string
    description  = string
    cidr_blocks  = list(string)
    source_sg_id = string
    self         = bool
  }))
}