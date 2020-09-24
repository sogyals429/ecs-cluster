data "template_file" "nginx" {
  template = file("${path.module}/templates/svc-template.tpl")
  vars     = {
    LOG_GROUP_NAME  = var.ecs_log_group
    CONTAINER_NAME  = "nginx-container"
    AWS_REGION      = var.aws_region
    CONF_BUCKET     = var.ecs_config_bucket
  }
}

# resource "aws_ecs_task_definition" "basic_service" {
#   family = "first-service"
#   container_definitions = ""
#   network_mode = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu = ""
#   memory = ""
#   task_role_arn = ""
# }

# resource "aws_ecs_service" "basic" {
#  name = "basic-service"
#  cluster = aws_ecs_cluster.ecs.id
#  task_definition = ""

# }
