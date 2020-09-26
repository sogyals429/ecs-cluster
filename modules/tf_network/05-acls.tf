# Public Network

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id
  subnet_ids = aws_subnet.public.*.id
}

resource "aws_network_acl_rule" "https_inbound"{
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "https_outbound"{
  network_acl_id = aws_network_acl.public.id
  rule_number    = 101
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "ssh_inbound"{
  network_acl_id = aws_network_acl.public.id
  rule_number    = 102
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "103.44.33.69/32"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "ssh_outbound"{
  network_acl_id = aws_network_acl.public.id
  rule_number    = 103
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}
resource "aws_network_acl_rule" "api_ingress_tcp_ephemeral" {
	network_acl_id = aws_network_acl.public.id
	egress = false 
  from_port =   1024 
  to_port = 65535 
  rule_action = "allow" 
  protocol = "tcp" 
  rule_number = 9999 
  cidr_block = "0.0.0.0/0" # Ephemeral ports tcp
}

resource "aws_network_acl_rule" "api_egress_tcp_ephemeral" {
	network_acl_id = aws_network_acl.public.id
	egress = true 
  from_port =   1024 
  to_port = 65535 
  rule_action = "allow" 
  protocol = "tcp" 
  rule_number = 9999 
  cidr_block = "0.0.0.0/0"  # Ephemeral ports tcp
}

# Private Network

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id
  subnet_ids = aws_subnet.private.*.id
}

resource "aws_network_acl_rule" "private_https_outbound"{
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "api_private_ingress_tcp_ephemeral" {
  network_acl_id = aws_network_acl.private.id
	egress = false 
  from_port =   1024 
  to_port = 65535 
  rule_action = "allow" 
  protocol = "tcp" 
  rule_number = 9999 
  cidr_block = "0.0.0.0/0" # 
}

resource "aws_network_acl_rule" "api_private_egress_tcp_ephemeral" {
  network_acl_id = aws_network_acl.private.id
	egress = true 
  from_port =   1024 
  to_port = 65535 
  rule_action = "allow" 
  protocol = "tcp" 
  rule_number = 9999 
  cidr_block = "0.0.0.0/0"  # Ephemeral ports
}