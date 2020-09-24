data "template_file" "nginx-proxy" {
  template = file("${path.module}/templates/svc-template.tpl")
  vars     = {
    LOG_GROUP_NAME  = var.ecs_log_group
    CONTAINER_NAME  = "nginx-container"
    AWS_REGION      = var.aws_region
    CONF_BUCKET     = var.ecs_config_bucket
  }
}

resource "aws_ecs_task_definition" "nginx-proxy" {
  family = "nginx-proxy-container"
  container_definitions = data.template_file.nginx-proxy.rendered
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  task_role_arn = aws_iam_role.ecs_api_task_assume.arn
  execution_role_arn = aws_iam_role.ecs_api_container_assume.arn
  
  lifecycle {
    create_before_destroy = "true"
  }

  tags = merge(
    map(
      "Name", "Fargate"
    ),
    var.common_tags
  )
}

# resource "aws_ecs_service" "basic" {
#  name = "basic-service"
#  cluster = aws_ecs_cluster.ecs.id
#  task_definition = ""

# }
