data "template_file" "ecs_api_task_assume"{
  template = file("${path.module}/templates/ecs_api_task_assume.json.tpl")
}

data "template_file" "ecs_api_container_assume"{
  template = file("${path.module}/templates/ecs_api_container_assume.json.tpl")
}

data "template_file" "ecs_api_task_assume_policy"{
  template = file("${path.module}/templates/ecs_api_task_assume_policy.json.tpl")
}

data "template_file" "ecs_api_container_assume_policy"{
  template = file("${path.module}/templates/ecs_api_container_assume_policy.json.tpl")
  vars = {
    conf_bucket = var.ecs_config_bucket_arn
  }
}

resource "aws_iam_role" "ecs_api_task_assume" {
  name = "ecs_api_task_assume"
  assume_role_policy = data.template_file.ecs_api_task_assume.rendered
  tags = merge(
    map(
      "Name", "ecs_api_task_assume"
    ),
    var.common_tags
  )
}

resource "aws_iam_role" "ecs_api_container_assume" {
  name = "ecs_api_container_assume"
  assume_role_policy = data.template_file.ecs_api_container_assume.rendered
  tags = merge(
    map(
      "Name", "ecs_api_container_assume"
    ),
    var.common_tags
  )
}

resource "aws_iam_role_policy" "ecs_api_task_assume" {
  name = "ecs_api_task_assume_policy"
  role = aws_iam_role.ecs_api_task_assume.id
  policy = data.template_file.ecs_api_task_assume_policy.rendered
}

resource "aws_iam_role_policy" "ecs_api_container_assume" {
  name = "ecs_api_container_assume_policy"
  role = aws_iam_role.ecs_api_container_assume.id
  policy = data.template_file.ecs_api_container_assume_policy.rendered
}