


### main.tf
module "aws_network" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  private_subnet_cidr1 = "10.0.3.0/24"
}

module "aws_security" {
  source = "./modules/sg"
  vpc_id = module.aws_network.vpc_id
   ingress_rules = {
    rule1 = {
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
      description  = "https"
      source_sg_id = null
      self         = null
    },
    rule2 = {
      from_port    = 80
      to_port      = 80
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
      description  = "http"
      source_sg_id = null
      self         = null
    },
    rule3 = {
      from_port    = 8081
      to_port      = 8081
      protocol     = "tcp"
      cidr_blocks  = ["10.0.0.0/8"]
      description  = "Workflow"
      source_sg_id = null
      self         = null
    }
  
   }
  egress_rules = {}

}

module "aws_nlb" {
  source = "./modules/nlb"
  vpc_id = module.aws_network.vpc_id
  public_subnet_ids = [module.aws_network.public_subnet_id,module.aws_network.private_subnet_id]
  security_group_id = module.aws_security.security_group_id

}

module "aws_compute" {
  source = "./modules/ec2"
  vpc_id = module.aws_network.vpc_id
  subnet_id = module.aws_network.public_subnet_id
  security_group_id = module.aws_security.security_group_id
    alb_target_group_arn = module.aws_nlb.alb_target_group_arn

}
