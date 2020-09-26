resource "aws_security_group" "api_proxy_sg" {
  name        = "api_proxy_sg"
  description = "API Proxy Layer Security Group"
  vpc_id      = var.vpc_id

  tags       = merge({ Name = "api_proxy_sg" }, var.common_tags)
}