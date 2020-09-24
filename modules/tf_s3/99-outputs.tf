output "terraform_ecs_config_bucket_arn" {
  value = aws_s3_bucket.ecs_config_bucket.arn
  description = "Config Bucket ARN for ecs services"
}

output "terraform_ecs_config_bucket_name" {
  value = aws_s3_bucket.ecs_config_bucket.bucket
  description = "Config Bucket Name for ecs services"
}