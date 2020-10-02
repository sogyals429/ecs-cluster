output "aws_security_group_ecs_api" {
  value = aws_security_group.api_proxy_sg.id
  description = "AWS Security Group for API Layer"
}

output "aws_security_group_api_lb" {
  value = aws_security_group.lb_api_proxy_sg.id
  description = "AWS Security Group for external ALB"
}