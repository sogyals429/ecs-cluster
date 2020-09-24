module "tf_ecs" {
  source                  = "./modules/tf_ecs"
  private_subnets         = var.private_subnets
  ecs_config_bucket_arn   = module.tf_s3.terraform_ecs_config_bucket_arn
  ecs_config_bucket       = module.tf_s3.terraform_ecs_config_bucket_name
  ecs_log_group           = module.tf_cloudwatch.ecs_cloudwatch_log_group
  aws_region              = var.aws_region
  common_tags             = local.common_tags
}

module "tf_network" {
  source          = "./modules/tf_network"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  common_tags     = local.common_tags
}

module "tf_s3" {
  source      = "./modules/tf_s3"
  common_tags = local.common_tags
}

module "tf_cloudwatch" {
  source      = "./modules/tf_cloudwatch"
  common_tags = local.common_tags
}