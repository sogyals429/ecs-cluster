output "ecs_cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.ecs-svc-logs.name
  description = "Log Group for ECS services"
}