# SG for External ALB
resource "aws_security_group" "lb_api_proxy_sg" {
  name        = "lb_api_proxy_sg"
  description = "External Application Load Balancer"
  vpc_id      = var.vpc_id

  tags       = merge({ Name = "api_proxy_lb_sg" }, var.common_tags)
}

resource "aws_security_group_rule" "lb_api_443_ingress_sg" {
	type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  self              = false
  cidr_blocks       = ["0.0.0.0/0"]
	description       = "Allows incoming traffic from the internet to ALB"
	security_group_id = aws_security_group.lb_api_proxy_sg.id
}

resource "aws_security_group_rule" "lb_api_443_egress_sg" {
	type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  self              = false
  cidr_blocks       = ["0.0.0.0/0"]
	description       = "Allows traffic to internal microservices"
	security_group_id = aws_security_group.lb_api_proxy_sg.id
}

# Interal SG for Microservices
resource "aws_security_group" "api_proxy_sg" {
  name        = "api_proxy_sg"
  description = "API Proxy Layer Security Group"
  vpc_id      = var.vpc_id

  tags       = merge({ Name = "api_proxy_sg" }, var.common_tags)
}

resource "aws_security_group_rule" "api_ms_443_egress_sg" {
	type              = "egress"  
  from_port         = 443 
  to_port           = 443 
  protocol          = "tcp" 
  self              = false 
  cidr_blocks       = ["0.0.0.0/0"]
	description       = "Allows outcoming traffic from internal microservices ECR and other sites"
	security_group_id = aws_security_group.api_proxy_sg.id
}