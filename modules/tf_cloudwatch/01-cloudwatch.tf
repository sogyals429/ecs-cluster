resource "aws_cloudwatch_log_group" "ecs-svc-logs" {
  name = "ecs-svc-logs"

  tags = merge(
    map(
      "Name", "ecs-svc-logs"
    ),
    var.common_tags
  )
}