data "template_file" "nginx-proxy" {
  template = file("${path.module}/templates/svc-template.tpl")
  vars     = {
    LOG_GROUP_NAME  = var.ecs_log_group
    CONTAINER_NAME  = "nginx-container"
    AWS_REGION      = var.aws_region
    CONF_BUCKET     = var.ecs_config_bucket
    REGISTRY_IMAGE  = "${var.proxy_api_server_image}:${var.proxy_api_server_version}" 
  }
}

resource "aws_ecs_task_definition" "nginx-proxy" {
  family = "nginx-proxy-container"
  container_definitions = data.template_file.nginx-proxy.rendered
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  task_role_arn = aws_iam_role.ecs_api_container_assume.arn
  execution_role_arn = aws_iam_role.ecs_api_task_assume.arn
  
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

resource "aws_ecs_service" "nginx-proxy" {
  name             = "nginx-proxy-service"
  cluster          = aws_ecs_cluster.ecs.id
  task_definition  = aws_ecs_task_definition.nginx-proxy.arn
  desired_count    = "1"
  launch_type      = "FARGATE"

  network_configuration {
    security_groups = [var.aws_security_group_ecs_api]
    subnets         = var.aws_subnet_private_api_id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_lb_target_group.arn
    container_name   = "nginx-container"
    container_port   = 80
  }

  lifecycle {
    create_before_destroy = "true"
  }
}