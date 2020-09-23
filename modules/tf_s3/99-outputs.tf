output "terraform_ecs_config_bucket" {
  value = aws_s3_bucket.ecs_config_bucket.arn
  description = "Config Bucket for ecs services"
}