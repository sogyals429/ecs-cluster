module "tf_ecs" {
  source              = "./modules/tf_ecs"
  private_subnets     = var.private_subnets
  ecs_config_bucket   = module.tf_s3.terraform_ecs_config_bucket
  common_tags         = local.common_tags
}

module "tf_network" {
  source          = "./modules/tf_network"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  common_tags     = local.common_tags
}

module "tf_s3" {
  source = "./modules/tf_s3"
  common_tags = local.common_tags
}