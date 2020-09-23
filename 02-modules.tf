module "tf_ecs" {
  source = "./modules/tf_ecs"
  private_subnets = var.private_subnets
  common_tags     = local.common_tags
}

module "tf_network" {
  source          = "./modules/tf_network"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  common_tags     = local.common_tags
}