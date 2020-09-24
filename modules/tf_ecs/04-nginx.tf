data "template_file" "basic_svc" {
  template = file("templates/svc-template.tpl")

}

resource "aws_ecs_task_definition" "basic_service" {
  family = "first-service"
  container_definitions = ""
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = ""
  memory = ""
  task_role_arn = ""
}

resource "aws_ecs_service" "basic" {
 name = "basic-service"
 cluster = aws_ecs_cluster.ecs.id
 task_definition = ""

}
