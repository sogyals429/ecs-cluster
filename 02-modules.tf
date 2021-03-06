module "tf_ecs" {
  source                     = "./modules/tf_ecs"
  private_subnets            = var.private_subnets
  ecs_config_bucket_arn      = module.tf_s3.terraform_ecs_config_bucket_arn
  ecs_config_bucket          = module.tf_s3.terraform_ecs_config_bucket_name
  ecs_log_group              = module.tf_cloudwatch.ecs_cloudwatch_log_group
  aws_region                 = var.aws_region
  proxy_api_server_image     = var.proxy_api_server_image
  proxy_api_server_version   = var.proxy_api_server_version
  common_tags                = local.common_tags
  vpc_id                     = module.tf_network.aws_vpc_id
  aws_security_group_ecs_api = module.tf_security.aws_security_group_ecs_api
  aws_security_group_api_lb  = module.tf_security.aws_security_group_api_lb
  aws_subnet_private_api_id  = module.tf_network.aws_private_subnets
  aws_subnet_public_api_id   = module.tf_network.aws_public_subnets
}

module "tf_network" {
  source          = "./modules/tf_network"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  common_tags     = local.common_tags
}

module "tf_security" {
  source      = "./modules/tf_security"
  vpc_id      = module.tf_network.aws_vpc_id
  common_tags = local.common_tags
}

module "tf_s3" {
  source      = "./modules/tf_s3"
  common_tags = local.common_tags
}

module "tf_cloudwatch" {
  source      = "./modules/tf_cloudwatch"
  common_tags = local.common_tags
}