resource "aws_s3_bucket" "ecs_config_bucket" {
  bucket     = "terraform-ecs-config-bucket"
  acl        = "private"
  
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = merge(
    map(
      "Name", "terraform_ecs_config_bucket"
    ),
    var.common_tags
  )

}

resource "aws_s3_bucket_public_access_block" "block-public-access-squid_conf_bucket" {
  bucket                  = aws_s3_bucket.ecs_config_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}